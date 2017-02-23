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
    public partial class addRecipe : baseForm
    {
        int employeeId;

        public addRecipe(int employeeId)
        {
            InitializeComponent();
            this.employeeId = employeeId;
            loadRecipe();
        }

        private void loadRecipe()
        {
            dataGridView1.Rows.Clear();
            comboBox1.Items.Clear();
            comboBox2.Items.Clear();

            int i = 1;
            foreach (var a in data.recipeheaders)
            {
                dataGridView1.Rows.Add(i, a.recipeid, a.food.foodname, a.description, a.outputunitinpieces);
                i++;
            }

            foreach (var a in data.foods)
            {
                comboBox1.Items.Add(a.foodname);
            } 
            
            foreach (var a in data.rawmaterials)
            {
                comboBox2.Items.Add(a.rawmaterialname);
            }


            comboBox1.SelectedIndex = 0;
            comboBox2.SelectedIndex = 0;
            countData();
        }

        private void searchRecipe()
        {
            dataGridView1.Rows.Clear();
            int i = 1;

            try
            {
                DateTime dt = DateTime.Parse(textBox1.Text);
                foreach (var a in data.recipeheaders.Where(x => x.description.Contains(textBox1.Text) || x.createddate.Equals(dt)))
                {
                    dataGridView1.Rows.Add(i, a.recipeid, a.food.foodname, a.description, a.outputunitinpieces);
                    i++;
                }
            }
            catch (Exception ex)
            {
                foreach (var a in data.recipeheaders.Where(x => x.description.Contains(textBox1.Text)))
                {
                    dataGridView1.Rows.Add(i, a.recipeid, a.food.foodname, a.description, a.outputunitinpieces);
                    i++;
                }
            }
        }

        private void clearText()
        {
            foreach (TextBox tb in this.Controls.OfType<TextBox>())
            {
                tb.Text = "";
            }
        }

        int rowIndex;
        int detailIndex;

        private void countData()
        {
            label10.Text = dataGridView1.Rows.Count + "";
        }

        private void button1_Click(object sender, EventArgs e)
        {
            searchRecipe();
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            rowIndex = e.RowIndex;
            textBox2.Text = dataGridView1.Rows[rowIndex].Cells[1].Value.ToString();
            comboBox1.Text = dataGridView1.Rows[rowIndex].Cells[2].Value.ToString();
            textBox5.Text = dataGridView1.Rows[rowIndex].Cells[3].Value.ToString();
            textBox4.Text = dataGridView1.Rows[rowIndex].Cells[4].Value.ToString();

            try
            {
                if (dataGridView1.Columns[e.ColumnIndex].Name == "ShowDetail")
                {
                    loadDetail(int.Parse(dataGridView1.Rows[rowIndex].Cells[1].Value.ToString()));
                }
            }
            catch (Exception ex) { }
        }

        private void loadDetail(int recipeid)
        {
            dataGridView2.Rows.Clear();
            int i = 1;
            foreach (var a in data.recipedetails.Where(x => x.recipeid.Equals(recipeid)))
            {
                dataGridView2.Rows.Add(i, recipeid, a.rawmaterialid, a.rawmaterial.rawmaterialname, a.weightingram);
                i++;
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            textBox1.Text = " ";

            if (textBox2.Text.Equals("") || textBox4.Text.Equals("") || textBox5.Text.Equals(""))
            {
                MessageBox.Show("Please complete the form!");
                return;
            }

            foreach (DataGridViewRow dgv in dataGridView1.Rows)
            {
                try
                {
                    if (textBox2.Text.Equals(dgv.Cells[1].Value.ToString()))
                    {
                        MessageBox.Show("Sorry, there is duplicate recipe id!");
                        return;
                    }
                }
                catch (Exception ex) { }
            }

            bool isRecipeValid = helper.isNumberValid(textBox2);
            bool isPieceValid = helper.isNumberValid(textBox4);

            if (isRecipeValid && isPieceValid)
            {
                int numRows = dataGridView1.Rows.Count;
                dataGridView1.Rows.Add(numRows, textBox2.Text, comboBox1.Text, textBox5.Text, textBox4.Text);
            }
            else
            {
                MessageBox.Show("Recipe Id and Output Piece should be a number");
                textBox2.Text = "";
                textBox4.Text = "";
                return;
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            textBox1.Text = " ";
            if (textBox2.Text.Equals("") || textBox4.Text.Equals("") || textBox5.Text.Equals(""))
            {
                MessageBox.Show("Please complete the form!");
                return;
            }

            bool isEmpIdValid = helper.isNumberValid(textBox2);
            bool isPhoneValid = helper.isNumberValid(textBox4);

            if (isEmpIdValid && isPhoneValid)
            {
                dataGridView1.Rows[rowIndex].Cells[1].Value = textBox2.Text;
                dataGridView1.Rows[rowIndex].Cells[2].Value = comboBox1.Text;
                dataGridView1.Rows[rowIndex].Cells[3].Value = textBox5.Text;
                dataGridView1.Rows[rowIndex].Cells[4].Value = textBox4.Text;
            }
            else
            {
                MessageBox.Show("Recipe Id and Output Piece should be a number");
                textBox2.Text = "";
                textBox4.Text = "";
                return;
            }

            countData();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            foreach (DataGridViewRow dgv in dataGridView1.Rows)
            {
                if (dgv.Cells[1].Value.ToString().Equals(textBox2.Text))
                {
                    dataGridView3.Rows.Add(dgv.Cells[0].Value.ToString());
                    dataGridView1.Rows.Remove(dgv);
                    clearText();
                }
            }

            countData();
        }

        private void button7_Click(object sender, EventArgs e)
        {
            textBox1.Text = " ";
            if (textBox8.Text.Equals(""))
            {
                MessageBox.Show("Please complete the form!");
                return;
            }

            bool isPhoneValid = helper.isNumberValid(textBox8);

            if (isPhoneValid)
            {
                int numRows = dataGridView2.Rows.Count;
                int recipeid = data.rawmaterials.Where(x => x.rawmaterialname.Equals(comboBox2.Text)).Select(x => x.rawmaterialid).First();

                if (dataGridView2.Rows.Count > 0)
                {
                    foreach (DataGridViewRow dgv in dataGridView2.Rows)
                    {
                        if (dgv.Cells[3].Value.ToString().Equals(comboBox2.Text))
                        {
                            dgv.Cells[4].Value = textBox8.Text;
                            return;
                        }
                        else
                        {
                            dataGridView2.Rows.Add(numRows, textBox2.Text, recipeid, comboBox2.Text, textBox8.Text);
                            return;
                        }
                    }
                }
                else
                {
                    dataGridView2.Rows.Add(numRows, textBox2.Text, recipeid, comboBox2.Text, textBox8.Text);
                }
            }
            else
            {
                MessageBox.Show("Weight in gram should be a number");
                textBox8.Text = "";
                return;
            }

            countData();
        }

        private void dataGridView2_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            detailIndex = e.RowIndex;
            no = dataGridView2.Rows[detailIndex].Cells[0].Value.ToString();
            comboBox2.Text = dataGridView2.Rows[detailIndex].Cells[3].Value.ToString();
            textBox8.Text = dataGridView2.Rows[detailIndex].Cells[4].Value.ToString();
        }

        string no;

        private void button5_Click(object sender, EventArgs e)
        {
            foreach (DataGridViewRow dgv in dataGridView2.Rows)
            {
                if (dgv.Cells[0].Value.ToString().Equals(no))
                {
                    dataGridView4.Rows.Add(dgv.Cells[1].Value.ToString(), dgv.Cells[2].Value.ToString());
                    dataGridView2.Rows.Remove(dgv);
                    clearText();
                }
            }

            countData();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            textBox1.Text = " ";
            if (textBox8.Text.Equals(""))
            {
                MessageBox.Show("Please complete the form!");
                return;
            }

            bool isPhoneValid = helper.isNumberValid(textBox8);

            if (isPhoneValid)
            {
                dataGridView2.Rows[detailIndex].Cells[1].Value = textBox2.Text;
                dataGridView2.Rows[detailIndex].Cells[2].Value = data.rawmaterials.Where(x => x.rawmaterialname.Equals(comboBox2.Text)).Select(x => x.rawmaterialid).First().ToString();
                dataGridView2.Rows[detailIndex].Cells[3].Value = comboBox2.Text;
                dataGridView2.Rows[detailIndex].Cells[4].Value = textBox8.Text;
            }
            else
            {
                MessageBox.Show("Weight in gram should be a number");
                textBox2.Text = "";
                textBox4.Text = "";
                return;
            }

            countData();
        }

        private void button8_Click(object sender, EventArgs e)
        {
            loadRecipe();
            dataGridView2.Rows.Clear();
            dataGridView3.Rows.Clear();
            dataGridView4.Rows.Clear();
            clearText();
        }

        private void button9_Click(object sender, EventArgs e)
        {
            string foodnames = dataGridView1.Rows[rowIndex].Cells[2].Value.ToString();
            int recipesid = int.Parse(dataGridView1.Rows[rowIndex].Cells[1].Value.ToString());
            int foodid = data.foods.Where(x => x.foodname.Equals(foodnames)).Select(x => x.foodid).First();

            int selling = data.sellingdetails.Where(x => x.foodid.Equals(foodid)).Sum(x => x.qty);

            try
            {
                int outputpieces = data.productiondetails.Where(x => x.foodid.Equals(foodid) && x.expireddate <= DateTime.Now).Sum(x => x.productionoutputqty);

                if (selling >= outputpieces)
                {
                    MessageBox.Show("Sorry, this food already sold. can't change recipe!");
                    return;
                }
            }
            catch (Exception ex) { }

            foreach (DataGridViewRow dgv in dataGridView1.Rows)
            {
                if (dataGridView3.Rows.Count > 0)
                {
                    foreach (DataGridViewRow dv in dataGridView3.Rows)
                    {
                        int recipeid = int.Parse(dv.Cells[0].Value.ToString());
                        var ems = data.recipeheaders.Find(recipeid);
                        try
                        {
                            data.recipeheaders.Remove(ems);
                            return;
                        }
                        catch (Exception ex) { }
                    }
                }

                if (dataGridView4.Rows.Count > 0)
                {
                    foreach (DataGridViewRow dv in dataGridView4.Rows)
                    {
                        int recipeid = int.Parse(dv.Cells[0].Value.ToString());
                        int rawid = int.Parse(dv.Cells[1].Value.ToString());
                        var ems = data.recipedetails.Where(x => x.recipeid.Equals(recipeid) && x.rawmaterialid.Equals(rawid)).First();
                        try
                        {
                            data.recipedetails.Remove(ems);
                            return;
                        }
                        catch (Exception ex) { }
                    }
                }

                int rawId = int.Parse(dgv.Cells[1].Value.ToString());
                var aa = data.recipeheaders.Where(x => x.recipeid.Equals(rawId));

                if (aa.Count() > 0)
                {
                    string foodname = dgv.Cells[2].Value.ToString();
                    var f = data.foods.Where(x => x.foodname.Equals(foodname)).First();

                    var em = data.recipeheaders.Where(x => x.recipeid.Equals(rawId)).First();
                    em.foodid = f.foodid;
                    em.outputunitinpieces = int.Parse(dgv.Cells[4].Value.ToString());
                    em.description = dgv.Cells[3].Value.ToString();
                    em.employeeid = aa.Select(x=>x.employeeid).First();
                    em.status = "A";
                    em.createddate = DateTime.Now;

                    try
                    {
                        foreach (DataGridViewRow dgv2 in dataGridView2.Rows)
                        {
                            int rawId2 = int.Parse(dgv2.Cells[1].Value.ToString());
                            int rawId3 = int.Parse(dgv2.Cells[2].Value.ToString());
                            int weight = int.Parse(dgv2.Cells[4].Value.ToString());
                            var aa2 = data.recipedetails.Where(x => x.recipeid.Equals(rawId2) && x.rawmaterialid.Equals(rawId3));

                            if (aa2.Count() > 0)
                            {
                                var up = aa2.First();
                                up.rawmaterialid = rawId3;
                                up.weightingram = weight;

                                try
                                {
                                    data.SaveChanges();
                                }
                                catch (Exception ex)
                                {
                                    continue;
                                }
                            }
                            else
                            {

                                int rawmaterialid = data.rawmaterials.Where(x => x.rawmaterialname.Equals(comboBox2.Text)).Select(x => x.rawmaterialid).First();

                                recipedetail ems = new recipedetail();
                                ems.recipeid = int.Parse(textBox2.Text);
                                ems.rawmaterialid = rawmaterialid;
                                ems.weightingram = int.Parse(textBox8.Text);

                                try
                                {
                                    data.recipedetails.Add(ems);
                                    data.SaveChanges();
                                }
                                catch (DbUpdateException ex)
                                {
                                    UpdateException updateEx = (UpdateException)ex.InnerException;
                                    SqlException sqlEx = (SqlException)updateEx.InnerException;
                                    continue;
                                }
                            }
                        }
                    }
                    catch (DbUpdateException ex)
                    {
                        UpdateException updateEx = (UpdateException)ex.InnerException;
                        SqlException sqlEx = (SqlException)updateEx.InnerException;
                        continue;
                    }
                }
                else
                {
                    string foodname = dgv.Cells[2].Value.ToString();
                    int foodsid = data.foods.Where(x => x.foodname.Equals(foodname)).Select(x => x.foodid).First();

                    recipeheader em = new recipeheader();
                    em.recipeid = int.Parse(textBox2.Text);
                    em.foodid = foodsid;
                    em.outputunitinpieces = int.Parse(dgv.Cells[4].Value.ToString());
                    em.description = dgv.Cells[3].Value.ToString();
                    em.employeeid = this.employeeId;
                    em.status = "A";
                    em.createddate = DateTime.Now;

                    try
                    {
                        data.recipeheaders.Add(em);
                        data.SaveChanges();

                        foreach (DataGridViewRow dgv2 in dataGridView2.Rows)
                        {
                            int rawId2 = int.Parse(dgv2.Cells[1].Value.ToString());
                            int rawId3 = int.Parse(dgv2.Cells[2].Value.ToString());
                            int rawId4 = int.Parse(dgv2.Cells[4].Value.ToString());
                            var aa2 = data.recipedetails.Where(x => x.recipeid.Equals(rawId2) && x.rawmaterialid.Equals(rawId3));

                            if (aa2.Count() > 0)
                            {
                                var up = aa2.First();
                                up.rawmaterialid = rawId3;
                                up.weightingram = rawId4;

                                try
                                {
                                    data.SaveChanges();
                                }
                                catch (Exception ex)
                                {
                                    UpdateException updateEx = (UpdateException)ex.InnerException;
                                    SqlException sqlEx = (SqlException)updateEx.InnerException;

                                    foreach (SqlError a in sqlEx.Errors)
                                    {
                                        MessageBox.Show(a.Message);
                                    }
                                    continue;
                                }
                            }
                            else
                            {
                                int rawmaterialid = data.rawmaterials.Where(x => x.rawmaterialname.Equals(comboBox2.Text)).Select(x => x.rawmaterialid).First();

                                recipedetail ems = new recipedetail();
                                ems.recipeid = int.Parse(textBox2.Text);
                                ems.rawmaterialid = rawmaterialid;
                                ems.weightingram = int.Parse(textBox8.Text);

                                try
                                {
                                    data.recipedetails.Add(ems);
                                    data.SaveChanges();
                                }
                                catch (Exception ex)
                                {
                                    UpdateException updateEx = (UpdateException)ex.InnerException;
                                    SqlException sqlEx = (SqlException)updateEx.InnerException;
                                    continue;
                                }
                            }
                        }
                    }
                    catch (DbUpdateException ex)
                    {
                        UpdateException updateEx = (UpdateException)ex.InnerException;
                        SqlException sqlEx = (SqlException)updateEx.InnerException;
                        continue;
                    }
                }
            }

            MessageBox.Show("Data updated!");
            loadRecipe();
        }
    }
}
