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
    public partial class addEmployee : baseForm
    {
        public addEmployee()
        {
            InitializeComponent();
            loadEmployee();
        }

        private void loadEmployee()
        {
            dataGridView1.Rows.Clear();
            int i = 1;
            foreach (var a in data.employees)
            {
                dataGridView1.Rows.Add(i, a.employeeid, a.employeename, a.password, a.employeeaddress, a.employeephone, a.status, a.email);
                i++;
            }

            countData();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            searchEmployee();
        }

        private void searchEmployee()
        {
            dataGridView1.Rows.Clear();
            int i = 1;
            foreach (var a in data.employees.Where(x=>x.employeename.Contains(textBox1.Text) || x.email.Contains(textBox1.Text) || x.employeeaddress.Contains(textBox1.Text) || x.employeephone.Contains(textBox1.Text)))
            {
                dataGridView1.Rows.Add(i, a.employeeid, a.employeename, a.password, a.employeeaddress, a.employeephone, a.status, a.email);
                i++;
            }
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
                        MessageBox.Show("Sorry, there is duplicate employee id!");
                        return;
                    }
                }
                catch (Exception ex) { }
            }

            bool isEmpIdValid = helper.isNumberValid(textBox2);
            bool isPhoneValid = helper.isNumberValid(textBox6);

            if (isEmpIdValid && isPhoneValid)
            {
                bool isEmailValid = helper.isEmailValid(textBox4.Text);
                if (isEmailValid)
                {
                    int numRows = dataGridView1.Rows.Count;
                    dataGridView1.Rows.Add(numRows, textBox2.Text, textBox3.Text, textBox5.Text, textBox7.Text, textBox6.Text, "A", textBox4.Text);
                }
                else
                {
                    MessageBox.Show("Email not valid!");
                    return;
                }
            }
            else
            {
                MessageBox.Show("Employee Id and Phone should be a number");
                textBox2.Text = "";
                textBox6.Text = "";
                return;
            }

            countData();
        }

        private void clearText()
        {
            foreach (TextBox tb in this.Controls.OfType<TextBox>())
            {
                tb.Text = "";
            }
        }

        string status = "A";
        int rowIndex;

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            rowIndex = e.RowIndex;
            textBox2.Text = dataGridView1.Rows[rowIndex].Cells[1].Value.ToString();
            textBox3.Text = dataGridView1.Rows[rowIndex].Cells[2].Value.ToString();
            textBox5.Text = dataGridView1.Rows[rowIndex].Cells[3].Value.ToString();
            textBox7.Text = dataGridView1.Rows[rowIndex].Cells[4].Value.ToString();
            textBox6.Text = dataGridView1.Rows[rowIndex].Cells[5].Value.ToString();
            status = dataGridView1.Rows[rowIndex].Cells[6].Value.ToString();
            textBox4.Text = dataGridView1.Rows[rowIndex].Cells[7].Value.ToString();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            textBox1.Text = " ";
            foreach (var a in this.Controls.OfType<TextBox>().Where(x => x.Text == ""))
            {
                MessageBox.Show("Please complete the form!");
                return;
            }

            bool isEmpIdValid = helper.isNumberValid(textBox2);
            bool isPhoneValid = helper.isNumberValid(textBox6);

            if (isEmpIdValid && isPhoneValid)
            {
                bool isEmailValid = helper.isEmailValid(textBox4.Text);
                if (isEmailValid)
                {

                    dataGridView1.Rows[rowIndex].Cells[1].Value = textBox2.Text;
                    dataGridView1.Rows[rowIndex].Cells[2].Value = textBox3.Text;
                    dataGridView1.Rows[rowIndex].Cells[3].Value = textBox5.Text;
                    dataGridView1.Rows[rowIndex].Cells[4].Value = textBox7.Text;
                    dataGridView1.Rows[rowIndex].Cells[5].Value = textBox6.Text;
                    dataGridView1.Rows[rowIndex].Cells[6].Value = status;
                    dataGridView1.Rows[rowIndex].Cells[7].Value = textBox4.Text;
                }
                else
                {
                    MessageBox.Show("Email not valid!");
                    return;
                }
            }
            else
            {
                MessageBox.Show("Employee Id and Phone should be a number");
                textBox2.Text = "";
                textBox6.Text = "";
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
                    dataGridView2.Rows.Add(dgv.Cells[1].Value.ToString());
                    dataGridView1.Rows.Remove(dgv);
                    clearText();
                }
            }

            countData();
        }

        private void countData()
        {
            label5.Text = dataGridView1.Rows.Count+"";
        }

        private void button6_Click(object sender, EventArgs e)
        {
            foreach (DataGridViewRow dgv in dataGridView1.Rows)
            {
                if (dataGridView2.Rows.Count > 0)
                {
                    foreach (DataGridViewRow dv in dataGridView2.Rows)
                    {
                        var ems = data.employees.Find(int.Parse(dv.Cells[0].Value.ToString()));
                        try
                        {
                            data.employees.Remove(ems);
                        }
                        catch (Exception ex) { }
                    }
                }

                int rawId = int.Parse(dgv.Cells[1].Value.ToString());
                var aa = data.employees.Where(x => x.employeeid.Equals(rawId)).Count();

                if (aa > 0)
                {
                    var em = data.employees.Where(x => x.employeeid.Equals(rawId)).First();
                    em.employeename = dgv.Cells[2].Value.ToString();
                    em.password = dgv.Cells[3].Value.ToString();
                    em.employeeaddress = dgv.Cells[4].Value.ToString();
                    em.employeephone = dgv.Cells[5].Value.ToString();
                    em.status = dgv.Cells[6].Value.ToString();
                    em.email = dgv.Cells[7].Value.ToString();

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
                    employee em = new employee();
                    em.employeeid = int.Parse(dgv.Cells[1].Value.ToString());
                    em.employeename = dgv.Cells[2].Value.ToString();
                    em.password = dgv.Cells[3].Value.ToString();
                    em.employeeaddress = dgv.Cells[4].Value.ToString();
                    em.employeephone = dgv.Cells[5].Value.ToString();
                    em.status = dgv.Cells[6].Value.ToString();
                    em.email = dgv.Cells[7].Value.ToString();

                    try
                    {
                        data.employees.Add(em);
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
            loadEmployee();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            loadEmployee();
            clearText();
        }
    }
}
