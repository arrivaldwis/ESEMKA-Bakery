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
    public partial class addSelling : baseForm
    {
        int employeeId;

        public addSelling(int employeeId)
        {
            InitializeComponent();
            this.employeeId = employeeId;
            loadData();
        }

        private void loadData()
        {
            foreach (var a in data.foods)
            {
                comboBox1.Items.Add(a.foodname);
            }
            comboBox1.SelectedIndex = 0;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (textBox1.Text == "")
            {
                MessageBox.Show("Please complete the field!");
                return;
            }

            int foodprice = data.foods.Where(x=>x.foodname.Equals(comboBox1.Text)).Select(x=>x.price).First();

            int numRows = dataGridView1.Rows.Count;

            numRows++;

            dataGridView1.Rows.Add(numRows, comboBox1.Text, foodprice, textBox1.Text, (foodprice * int.Parse(textBox1.Text)));

            calculateTotalPrice();
        }

        private void calculateTotalPrice()
        {
            int totalPrice = 0;
            foreach (DataGridViewRow dgv in dataGridView1.Rows)
            {
                totalPrice += int.Parse(dgv.Cells[4].Value.ToString());
            }
            textBox4.Text = totalPrice + "";
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            if (textBox2.Text.Length > 0)
            {
                textBox3.Text = (int.Parse(textBox4.Text) - (int.Parse(textBox4.Text) * (float.Parse(textBox2.Text)/100)))+"";
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
                            calculateTotalPrice();
                        }
                    }
                }
            }
            catch (Exception ex) { }
        }

        class foodBatch {
            public int sellingid { get; set; }
            public string foodname {get;set;}
            public string batch {get;set;}
            public int qty { get; set; }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (textBox2.Text == "" || textBox3.Text == "" || textBox4.Text == "")
            {
                MessageBox.Show("Please complete the field!");
                return;
            }

            sellingheader se = new sellingheader();
            se.sellingdate = DateTime.Now;
            se.discount = int.Parse(textBox2.Text);
            se.employeeid = this.employeeId;

            try
            {
                data.sellingheaders.Add(se);
                data.SaveChanges();

                List<foodBatch> food_name = new List<foodBatch>();

                foreach (DataGridViewRow a in dataGridView1.Rows)
                {
                    string foodname = a.Cells[1].Value.ToString();
                    var product = data.productiondetails.Where(x => x.food.foodname.Equals(foodname));

                    int qtyPer = int.Parse(a.Cells[3].Value.ToString());
                    int qty = int.Parse(a.Cells[3].Value.ToString());
                    foreach (var b in product)
                    {
                        if (qty > 0)
                        {
                            if (b.productionoutputqty >= qty)
                            {
                                b.productionoutputqty -= qty;

                                food_name.Add(new foodBatch {
                                    sellingid = se.sellingid,
                                    foodname = b.food.foodname,
                                    batch = b.batchnumber.ToString(),
                                    qty = qty
                                });

                                qty = 0;
                            }
                            else
                            {
                                if (b.productionoutputqty > 0)
                                {
                                    qty -= b.productionoutputqty;

                                    food_name.Add(new foodBatch
                                    {
                                        sellingid = se.sellingid,
                                        foodname = b.food.foodname,
                                        batch = b.batchnumber.ToString(),
                                        qty = b.productionoutputqty
                                    });

                                    b.productionoutputqty -= b.productionoutputqty;
                                }
                                else
                                {
                                    continue;
                                }
                            }
                        }
                    }

                    try
                    {
                        data.SaveChanges();

                        foreach (var batch in food_name)
                        {
                            int foodid = data.foods.Where(x=>x.foodname.Equals(batch.foodname)).Select(x=>x.foodid).First();

                            int foodprice = data.foods.Where(x => x.foodname.Equals(batch.foodname)).Select(x => x.price).First();

                            sellingdetail sd = new sellingdetail();
                            sd.sellingid = batch.sellingid;
                            sd.foodid = foodid;
                            sd.batchnumber = int.Parse(batch.batch);
                            sd.qty = batch.qty;
                            sd.price = foodprice * batch.qty;

                            try
                            {
                                data.sellingdetails.Add(sd);
                                data.SaveChanges();
                            }
                            catch (EntityException ex)
                            {
                                SqlException updateEx = (SqlException)ex.InnerException;
                                EntitySqlException sqlEx = (EntitySqlException)updateEx.InnerException;

                                MessageBox.Show(updateEx.Message);
                            }
                        }
                    }
                    catch (EntityException ex)
                    {
                        SqlException updateEx = (SqlException)ex.InnerException;
                        EntitySqlException sqlEx = (EntitySqlException)updateEx.InnerException;

                        MessageBox.Show(updateEx.Message);
                    }
                }
            }
            catch (DbUpdateException ex)
            {
                UpdateException updateEx = (UpdateException)ex.InnerException;
                SqlException sqlEx = (SqlException)updateEx.InnerException;
            }

            MessageBox.Show("Data updated!");
        }
    }
}
