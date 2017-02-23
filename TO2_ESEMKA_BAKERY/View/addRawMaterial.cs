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
    public partial class addRawMaterial : baseForm
    {
        int employeeId;
        public addRawMaterial(int employeeId)
        {
            InitializeComponent();
            loadRawMaterial();
            this.employeeId = employeeId;
        }

        private void loadRawMaterial()
        {
            dataGridView1.Rows.Clear();
            int i = 1;
            foreach (var a in data.rawmaterials)
            {
                dataGridView1.Rows.Add(i, a.rawmaterialid, a.rawmaterialname, a.description, a.employee.employeename, a.inputeddate);
                i++;
            }

            countData();
        }

        private void searchRawMaterial()
        {
            dataGridView1.Rows.Clear();
            int i = 1;

            try
            {
                DateTime input = DateTime.Parse(textBox1.Text);
                foreach (var a in data.rawmaterials.Where(x => x.rawmaterialname.Contains(textBox1.Text) || x.description.Contains(textBox1.Text) || x.inputeddate.Equals(textBox1.Text)))
                {
                    dataGridView1.Rows.Add(i, a.rawmaterialid, a.rawmaterialname, a.description, a.employee.employeename, a.inputeddate);
                    i++;
                }
            }
            catch (Exception ex)
            {
                foreach (var a in data.rawmaterials.Where(x => x.rawmaterialname.Contains(textBox1.Text) || x.description.Contains(textBox1.Text)))
                {
                    dataGridView1.Rows.Add(i, a.rawmaterialid, a.rawmaterialname, a.description, a.employee.employeename, a.inputeddate);
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

            int numRows = dataGridView1.Rows.Count;
            dataGridView1.Rows.Add(numRows, textBox2.Text, textBox3.Text, textBox4.Text, data.employees.Where(x=>x.employeeid.Equals(this.employeeId)).Select(x=>x.employeename).First(), DateTime.Now);

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

            dataGridView1.Rows[rowIndex].Cells[1].Value = textBox2.Text;
            dataGridView1.Rows[rowIndex].Cells[2].Value = textBox3.Text;
            dataGridView1.Rows[rowIndex].Cells[3].Value = textBox4.Text;

            countData();
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

        private void button6_Click(object sender, EventArgs e)
        {
            foreach (DataGridViewRow dgv in dataGridView1.Rows)
            {
                if (dataGridView2.Rows.Count > 0)
                {
                    foreach (DataGridViewRow dv in dataGridView2.Rows)
                    {
                        var ems = data.rawmaterials.Find(int.Parse(dv.Cells[0].Value.ToString()));
                        try
                        {
                            data.rawmaterials.Remove(ems);
                        }
                        catch (Exception ex) { }
                    }
                }

                int rawId = int.Parse(dgv.Cells[1].Value.ToString());
                var aa = data.rawmaterials.Where(x => x.rawmaterialid.Equals(rawId)).Count();

                if (aa > 0)
                {
                    var em = data.rawmaterials.Where(x => x.rawmaterialid.Equals(rawId)).First();
                    em.rawmaterialname = dgv.Cells[2].Value.ToString();
                    em.description = dgv.Cells[3].Value.ToString();
                    em.employeeid = this.employeeId;
                    em.inputeddate = DateTime.Now;
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
                    rawmaterial em = new rawmaterial();
                    em.rawmaterialid = int.Parse(dgv.Cells[1].Value.ToString());
                    em.rawmaterialname = dgv.Cells[2].Value.ToString();
                    em.description = dgv.Cells[3].Value.ToString();
                    em.employeeid = this.employeeId;
                    em.inputeddate = DateTime.Now;
                    em.status = "A";

                    try
                    {
                        data.rawmaterials.Add(em);
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
            dataGridView2.Rows.Clear();
            loadRawMaterial();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            loadRawMaterial();
            clearText();
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            rowIndex = e.RowIndex;
            textBox2.Text = dataGridView1.Rows[rowIndex].Cells[1].Value.ToString();
            textBox3.Text = dataGridView1.Rows[rowIndex].Cells[2].Value.ToString();
            textBox4.Text = dataGridView1.Rows[rowIndex].Cells[3].Value.ToString();
        }

        private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            searchRawMaterial();
        }
    }
}
