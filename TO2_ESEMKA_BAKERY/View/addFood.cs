using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Entity.Core;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Validation;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace TO2_ESEMKA_BAKERY.View
{
    public partial class addFood : baseForm
    {
        public addFood()
        {
            InitializeComponent();
            loadFood();
        }

        private void loadFood()
        {
            dataGridView1.Rows.Clear();
            int i = 1;
            foreach (var a in data.foods)
            {
                dataGridView1.Rows.Add(i, a.foodid, a.foodname, a.description, a.price, a.status);
                i++;
            }

            countData();
        }

        private void searchFood()
        {
            dataGridView1.Rows.Clear();
            int i = 1;
            try
            {
                int price = int.Parse(textBox1.Text);
                foreach (var a in data.foods.Where(x => x.foodname.Contains(textBox1.Text) || x.description.Contains(textBox1.Text) || x.price.Equals(price)))
                {
                    dataGridView1.Rows.Add(i, a.foodid, a.foodname, a.description, a.price, a.status);
                    i++;
                }
            }
            catch (Exception ex)
            {
                foreach (var a in data.foods.Where(x => x.foodname.Contains(textBox1.Text) || x.description.Contains(textBox1.Text)))
                {
                    dataGridView1.Rows.Add(i, a.foodid, a.foodname, a.description, a.price, a.status);
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

        private void countData()
        {
            label5.Text = dataGridView1.Rows.Count + "";
        }

        private void button2_Click(object sender, EventArgs e)
        {
            textBox1.Text = " ";
            foreach (var a in this.Controls.OfType<TextBox>().Where(x => x.Text == ""))
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
                        MessageBox.Show("Sorry, there is duplicate food id!");
                        return;
                    }
                }
                catch (Exception ex) { }
            }

            bool isPriceValid = helper.isNumberValid(textBox5);
            if (!isPriceValid)
            {
                MessageBox.Show("Price should be number!");
                return;
            }

            int numRows = dataGridView1.Rows.Count;
            dataGridView1.Rows.Add(numRows, textBox2.Text,textBox3.Text, textBox4.Text, textBox5.Text, "A");

            countData();
        }

        private void addFood_Load(object sender, EventArgs e)
        {

        }

        private void button4_Click(object sender, EventArgs e)
        {
            foreach (DataGridViewRow dgv in dataGridView1.Rows)
            {
                if (dgv.Cells[1].Value.ToString().Equals(textBox2.Text))
                {
                    dataGridView2.Rows.Add(dgv.Cells[1].Value.ToString());
                    dataGridView1.Rows.Remove(dgv);
                    clearText();
                }
            }

            countData();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            textBox1.Text = " ";
            foreach (var a in this.Controls.OfType<TextBox>().Where(x => x.Text == ""))
            {
                MessageBox.Show("Please complete the form!");
                return;
            }

            bool isPriceValid = helper.isNumberValid(textBox5);
            if (!isPriceValid)
            {
                MessageBox.Show("Price should be number!");
                return;
            }

            dataGridView1.Rows[rowIndex].Cells[1].Value = textBox2.Text;
            dataGridView1.Rows[rowIndex].Cells[2].Value = textBox3.Text;
            dataGridView1.Rows[rowIndex].Cells[3].Value = textBox4.Text;
            dataGridView1.Rows[rowIndex].Cells[4].Value = textBox5.Text;
            dataGridView1.Rows[rowIndex].Cells[5].Value = status;

            countData();
        }

        string status = "A";

        private void button5_Click(object sender, EventArgs e)
        {
            loadFood();
            clearText();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            foreach (DataGridViewRow dgv in dataGridView1.Rows)
            {
                if (dataGridView2.Rows.Count > 0)
                {
                    foreach (DataGridViewRow dv in dataGridView2.Rows)
                    {
                        var ems = data.foods.Find(int.Parse(dv.Cells[0].Value.ToString()));
                        try
                        {
                            data.foods.Remove(ems);
                        }
                        catch (Exception ex) { }
                    }
                }

                int rawId = int.Parse(dgv.Cells[1].Value.ToString());
                var aa = data.foods.Where(x => x.foodid.Equals(rawId)).Count();

                if (aa > 0)
                {
                    var em = data.foods.Where(x => x.foodid.Equals(rawId)).First();
                    em.foodname = dgv.Cells[2].Value.ToString();
                    em.description = dgv.Cells[3].Value.ToString();
                    em.price = int.Parse(dgv.Cells[4].Value.ToString());
                    em.status = "A";

                    try
                    {
                        data.SaveChanges();
                    }
                    catch (DbUpdateException ex)
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
                    food em = new food();
                    em.foodid = int.Parse(dgv.Cells[1].Value.ToString());
                    em.foodname = dgv.Cells[2].Value.ToString();
                    em.description = dgv.Cells[3].Value.ToString();
                    em.price = int.Parse(dgv.Cells[4].Value.ToString());
                    em.status = "A";

                    try
                    {
                        data.foods.Add(em);
                        data.SaveChanges();
                    }
                    catch (DbUpdateException ex)
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
            }

            MessageBox.Show("Data updated!");
            loadFood();
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            rowIndex = e.RowIndex;
            textBox2.Text = dataGridView1.Rows[rowIndex].Cells[1].Value.ToString();
            textBox3.Text = dataGridView1.Rows[rowIndex].Cells[2].Value.ToString();
            textBox4.Text = dataGridView1.Rows[rowIndex].Cells[3].Value.ToString();
            textBox5.Text = dataGridView1.Rows[rowIndex].Cells[4].Value.ToString();
            status = dataGridView1.Rows[rowIndex].Cells[5].Value.ToString();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            searchFood();
        }
    }
}
