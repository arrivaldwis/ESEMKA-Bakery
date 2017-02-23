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
    public partial class addIncomingRawMaterial : baseForm
    {
        int counter = 1;

        public addIncomingRawMaterial()
        {
            InitializeComponent();
            loadData();
        }

        private void loadData()
        {
            foreach (var a in data.rawmaterials)
            {
                comboBox1.Items.Add(a.rawmaterialname);
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
            foreach (var a in this.Controls.OfType<TextBox>().Where(x => x.Text == ""))
            {
                MessageBox.Show("Please complete the field!");
                return;
            }

            bool isWeightValid = helper.isNumberValid(textBox1);
            bool isPriceValid = helper.isNumberValid(textBox2);

            if (isWeightValid && isPriceValid)
            {
                int numRows = dataGridView1.Rows.Count;
                if (numRows == 0) { numRows = 1; }
                dataGridView1.Rows.Add(numRows, comboBox1.Text, dateTimePicker1.Value, textBox1.Text, textBox2.Text);
            }
            else
            {
                MessageBox.Show("Weight and Price should be number!");
                return;
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
            incomingrawmaterialheader a = new incomingrawmaterialheader();
            a.incomingdate = dateTimePicker2.Value;
            a.employeeid = data.employees.Where(x => x.employeename.Equals(comboBox2.Text)).Select(x => x.employeeid).First();
            a.description = textBox3.Text;

            try
            {
                data.incomingrawmaterialheaders.Add(a);
                data.SaveChanges();

                foreach (DataGridViewRow dgv in dataGridView1.Rows)
                {
                    string rawname = dgv.Cells[1].Value.ToString();
                    int rawmaterialid = data.rawmaterials.Where(x => x.rawmaterialname.Equals(rawname)).Select(x => x.rawmaterialid).First();

                    DateTime bbd = DateTime.Parse(dgv.Cells[2].Value.ToString());

                    incomingrawmaterialdetail b = new incomingrawmaterialdetail();
                    b.incomingrawmaterialid = a.incomingrawmaterialid;
                    b.rawmaterialid = rawmaterialid;
                    b.priceper100gram = int.Parse(dgv.Cells[4].Value.ToString());
                    b.bestbeforedate = bbd;
                    b.weightingram = int.Parse(dgv.Cells[3].Value.ToString());

                    try
                    {
                        data.incomingrawmaterialdetails.Add(b);
                        data.SaveChanges();
                    }
                    catch (DbUpdateException ex)
                    {
                        UpdateException updateEx = (UpdateException)ex.InnerException;
                        SqlException sqlEx = (SqlException)updateEx.InnerException;

                        foreach (SqlError av in sqlEx.Errors)
                        {
                            MessageBox.Show(av.Message);
                        }
                        continue;
                    }
                }
            }
            catch (DbUpdateException ex)
            {
                UpdateException updateEx = (UpdateException)ex.InnerException;
                SqlException sqlEx = (SqlException)updateEx.InnerException;

                foreach (SqlError av in sqlEx.Errors)
                {
                    MessageBox.Show(av.Message);
                }
            }

            MessageBox.Show("Date updated!");
        }
    }
}
