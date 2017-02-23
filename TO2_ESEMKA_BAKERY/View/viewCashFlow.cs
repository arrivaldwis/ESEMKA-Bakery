using Microsoft.Reporting.WinForms;
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
using TO2_ESEMKA_BAKERY.Class;

namespace TO2_ESEMKA_BAKERY.View
{
    public partial class viewCashFlow : baseForm
    {
        public viewCashFlow()
        {
            InitializeComponent();
            loadFoods();
        }

        private void viewCashFlow_Load(object sender, EventArgs e)
        {
            
        }

        class incomePerDate
        {
            public int income { get; set; }
            public DateTime date { get; set; }
            public int outcome { get; set; }
        }

        class rawMaterialTake
        {
            public int rawmaterialid { get; set; }
            public int weight { get; set; }
        }

        private void loadGraphic()
        {
            Random r = new Random();

            List<incomePerDate> dateClass = new List<incomePerDate>();
            List<incomePerWeek> weekClass = new List<incomePerWeek>();
            List<rawMaterialTake> rawIntake = new List<rawMaterialTake>();
            List<CashflowModel> cash = new List<CashflowModel>();
            List<sellingdetail> selDetail = new List<sellingdetail>();
            List<string> weeks = new List<string>();

            int outcome = 0;
            int totalIncome = 0;
            int totalOutcome = 0;

                foreach (DataGridViewRow dgv in dataGridView1.Rows)
                {
                    int foodid = int.Parse(dgv.Cells[0].Value.ToString());
                    var food = data.foods.Find(foodid);

                    selDetail = data.sellingdetails.Where(x => x.foodid.Equals(foodid) && x.sellingheader.sellingdate >= dateTimePicker1.Value && x.sellingheader.sellingdate <= dateTimePicker2.Value).ToList();

                    try
                    {
                        foreach (var a in selDetail) 
                        {
                            try
                            {
                                var prodDetails = data.productiondetails.Where(x => x.foodid.Equals(foodid) && x.batchnumber.Equals(a.batchnumber)).FirstOrDefault();

                                var recipeheader = data.recipeheaders.Where(x => x.foodid.Equals(foodid)).FirstOrDefault();

                                int prodOutput = prodDetails.productionoutputqty;

                                foreach (var ab in data.recipedetails.Where(x => x.recipeid.Equals(recipeheader.recipeid)))
                                {
                                    var priceRaw = data.incomingrawmaterialdetails.Where(x => x.rawmaterialid.Equals(ab.rawmaterialid)).FirstOrDefault();

                                    rawIntake.Add(new rawMaterialTake
                                    {
                                        rawmaterialid = ab.rawmaterialid,
                                        weight = (ab.weightingram / 100) * priceRaw.priceper100gram
                                    });
                                    outcome += (ab.weightingram / 100) * priceRaw.priceper100gram;
                                }
                            }
                            catch (Exception ex) { }

                            dateClass.Add(new incomePerDate
                            {
                                income = a.qty * (food.price/1000),
                                date = a.sellingheader.sellingdate,
                                outcome = outcome
                            });
                        }
                        
                    }
                    catch (DbUpdateException ex)
                    {
                        UpdateException updateEx = (UpdateException)ex.InnerException;
                        SqlException sqlEx = (SqlException)updateEx.InnerException;

                        foreach (SqlError a in sqlEx.Errors)
                        {
                            MessageBox.Show(a.Message);
                        }
                        return;
                    }
                }

                int classCount = dateClass.Count;
                int week = 1;

                int ia = 0;

                foreach (var a in dateClass)
                {
                    totalIncome += a.income;
                    totalOutcome += a.outcome;

                    ia++;

                    if (ia % 7 == 0)
                    {
                        cash.Add(new CashflowModel
                        {
                            income = totalIncome,
                            outcome = totalOutcome,
                            week = week
                        });

                        week++;
                        totalIncome = 0;
                        totalOutcome = 0;
                    }
                }

            this.reportViewer1.LocalReport.DataSources.Clear();
            this.reportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", cash));
            this.reportViewer1.RefreshReport();
        }

        class incomePerWeek
        {
            public int week { get; set; }
            public int income { get; set; }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (dateTimePicker2.Value <= dateTimePicker1.Value)
            {
                MessageBox.Show("End Date can't be lower or same with Start date!");
                return;
            }

            loadGraphic();
        }

        private void loadFoods()
        {
            flowLayoutPanel1.Controls.Clear();

            foreach (var a in data.foods)
            {
                CheckBox ck = new CheckBox();
                ck.Name = a.foodname;
                ck.Text = a.foodname;
                ck.Tag = a.foodname;
                ck.CheckedChanged += ck_CheckedChanged;
                flowLayoutPanel1.Controls.Add(ck);
            }

            CheckBox allProduct = new CheckBox();
            allProduct.Name = "All";
            allProduct.Text = "All Products";
            allProduct.Tag = "All";
            allProduct.CheckedChanged += ck_CheckedChanged;
            flowLayoutPanel1.Controls.Add(allProduct);
        }

        void ck_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox cka = (CheckBox)sender;
            int foodid = 0;
            List<food> food = new List<food>();
            int all = 0;

            try
            {
                foodid = data.foods.Where(x => x.foodname.Equals(cka.Tag.ToString())).Select(x => x.foodid).First();
            }
            catch (Exception ex)
            {
                food = data.foods.ToList();
                all = 1;
            }

            if (cka.Checked)
            {
                if (all == 1)
                {
                    foreach (CheckBox flow in flowLayoutPanel1.Controls.OfType<CheckBox>())
                    {
                        flow.Checked = true;
                    }

                    dataGridView1.Rows.Clear();

                    foreach (var a in food)
                    {
                        dataGridView1.Rows.Add(a.foodid, a.foodname);
                    }
                }
                else
                {
                    if (foodid != 0)
                    {
                        dataGridView1.Rows.Add(foodid, cka.Tag);
                    }
                    else
                    {
                        dataGridView1.Rows.Clear();
                        foreach (var a in food)
                        {
                            dataGridView1.Rows.Add(a.foodid, a.foodname);
                        }
                    }
                }
            }
            else
            {
                foreach (DataGridViewRow dgv in dataGridView1.Rows)
                {
                    if (all == 1)
                    {
                        dataGridView1.Rows.Clear();
                        foreach (CheckBox flow in flowLayoutPanel1.Controls.OfType<CheckBox>())
                        {
                            flow.Checked = false;
                        }
                    }
                    else
                    {
                        if (dgv.Cells[1].Value.ToString().Equals(cka.Tag))
                        {
                            dataGridView1.Rows.Remove(dgv);
                        }
                    }
                }
            }
        }
    }
}
