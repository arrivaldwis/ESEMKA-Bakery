using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Entity.Core;
using System.Data.Entity.Infrastructure;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace TO2_ESEMKA_BAKERY.View
{
    public partial class addProduction : baseForm
    {
        public addProduction()
        {
            InitializeComponent();
            loadData();
        }

        private void loadData()
        {
            foreach (var a in data.foods)
            {
                comboBox1.Items.Add(a.foodname);
            } 
            
            foreach (var a in data.employees)
            {
                comboBox2.Items.Add(a.employeename);
            }

            comboBox1.SelectedIndex = 0;
            comboBox2.SelectedIndex = 0;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            dataGridView1.Rows.Clear();

            int numRows = dataGridView1.Rows.Count;
            numRows++;

            var bm = data.recipeheaders.Where(x => x.food.foodname.Equals(comboBox1.Text)).First();
            foreach (var a in data.recipedetails.Where(x=>x.recipeid.Equals(bm.recipeid)))
            {
                var rawmaterialname = data.rawmaterials.Find(a.rawmaterialid);
                dataGridView1.Rows.Add(numRows, comboBox1.Text, rawmaterialname.rawmaterialname, a.weightingram);
                numRows++;
            }
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int rowIndex = e.RowIndex;
            try
            {
                if (dataGridView1.Columns[e.ColumnIndex].Name == "Delete")
                {
                    foreach (DataGridViewRow dgv in dataGridView1.Rows)
                    {
                        if (dgv.Cells[0].Value.ToString().Equals(dataGridView1.Rows[rowIndex].Cells[0].Value.ToString()))
                        {
                            dataGridView1.Rows.Remove(dgv);
                        }
                    }
                }
            }
            catch (Exception ex) { }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            insertHeader();
        }

        private void insertHeader()
        {
            int employeeId = data.employees.Where(x => x.employeename.Equals(comboBox2.Text)).Select(x => x.employeeid).First();

            productionheader a = new productionheader();
            a.productiondate = dateTimePicker1.Value;
            a.description = "Production at "+dateTimePicker1.Value.TimeOfDay;
            a.employeeid = employeeId;
            a.status = "A";

            try
            {
                data.productionheaders.Add(a);
                data.SaveChanges();
                dividedProcess();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        class resultOfDivided
        {
            public int foodId { get; set; }
            public int rawMaterialId { get; set; }
            public string rawMaterialName { get; set; }
            public int inputRaw { get; set; }
            public int foodPerQty { get; set; }
            public float rawLeft { get; set; }
            public int modLeft { get; set; }
        }

        List<resultOfDivided> hasilBagiProd = new List<resultOfDivided>();
        List<resultOfDivided> hasilBagiProd2 = new List<resultOfDivided>();

        int foodPerQty;

        private void dividedProcess() {
            foreach(DataGridViewRow dgv in dataGridView1.Rows) {
                string foodName = dgv.Cells[1].Value.ToString();
                string rawMaterialName = dgv.Cells[2].Value.ToString();
                int inputWeight = int.Parse(dgv.Cells[3].Value.ToString());

                int foodId = data.foods.Where(x=>x.foodname.Equals(foodName)).Select(x=>x.foodid).First();

                int recipeid = data.recipeheaders.Where(x => x.foodid.Equals(foodId)).Select(x => x.recipeid).First();

                int outputFoodQty = data.recipeheaders.Where(x => x.foodid.Equals(foodId)).Select(x => x.outputunitinpieces).First();

                int rawMaterialId = data.rawmaterials.Where(x=>x.rawmaterialname.Equals(rawMaterialName)).Select(x=>x.rawmaterialid).First();

                var a = data.recipedetails.Where(x => x.recipeid.Equals(recipeid) && x.rawmaterialid.Equals(rawMaterialId)).First();

                foodPerQty = a.weightingram / outputFoodQty;
                float bagi2 = inputWeight / foodPerQty;

                hasilBagiProd.Add(new resultOfDivided
                {
                    foodId = foodId,
                    rawMaterialId = rawMaterialId,
                    rawMaterialName = rawMaterialName,
                    inputRaw = inputWeight,
                    foodPerQty = foodPerQty,
                    rawLeft = bagi2,
                    modLeft = 0
                });
            }

            getLowestRaw();
        }

        private void getLowestRaw()
        {
            float lowestRaw = hasilBagiProd.Select(x => x.rawLeft).Min();
            foreach (var a in hasilBagiProd)
            {
                a.rawLeft -= lowestRaw;
                int mod = (int)a.inputRaw % a.foodPerQty;
                a.rawLeft *= foodPerQty;
                a.rawLeft += (int)mod;

                a.inputRaw -= (int) a.rawLeft;

                hasilBagiProd2.Add(new resultOfDivided
                {
                    foodId = a.foodId,
                    rawMaterialId = a.rawMaterialId,
                    rawMaterialName = a.rawMaterialName,
                    inputRaw = a.inputRaw,
                    foodPerQty = a.foodPerQty,
                    rawLeft = a.rawLeft,
                    modLeft = (int)mod
                });
            }

            var last = data.productiondetails.OrderByDescending(x => x.productionid).First();
            var last2 = data.rawmaterialintakes.OrderByDescending(x => x.batchnumber).First();
            foreach (var b in hasilBagiProd2)
            {
                MessageBox.Show(b.inputRaw+"");

                var a = data.incomingrawmaterialdetails.Where(x => x.rawmaterialid.Equals(b.rawMaterialId) && DateTime.Now <= x.bestbeforedate).First();
                a.weightingram -= b.inputRaw;

                try
                {
                    data.SaveChanges();

                    productiondetail xa = new productiondetail();
                    xa.productionid = last.productionid + 1;
                    xa.batchnumber = last.batchnumber + 1;
                    xa.foodid = b.foodId;
                    xa.productionoutputqty = b.inputRaw;
                    xa.expireddate = dateTimePicker1.Value;

                    try
                    {
                        data.productiondetails.Add(xa);
                        data.SaveChanges();

                        rawmaterialintake rmi = new rawmaterialintake();
                        rmi.batchnumber = last2.batchnumber + 1;
                        rmi.rawmaterialid = b.rawMaterialId;
                        rmi.incomingrawmaterialid = a.incomingrawmaterialid;
                        rmi.weightingram = b.inputRaw;

                        try
                        {
                            data.rawmaterialintakes.Add(rmi);
                            data.SaveChanges();
                        }
                        catch (EntityException ex)
                        {
                            SqlException updateEx = (SqlException)ex.InnerException;
                            EntitySqlException sqlEx = (EntitySqlException)updateEx.InnerException;

                            MessageBox.Show(updateEx.Message);
                        }
                    }
                    catch (EntityException ex)
                    {
                        SqlException updateEx = (SqlException)ex.InnerException;
                        EntitySqlException sqlEx = (EntitySqlException)updateEx.InnerException;

                        MessageBox.Show(updateEx.Message);
                    }
                }
                catch (DbUpdateException ex)
                {
                }
            }

            MessageBox.Show("Data updated!");
        }
    }
}
