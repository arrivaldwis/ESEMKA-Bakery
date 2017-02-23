using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace TO2_ESEMKA_BAKERY.View
{
    public partial class viewFoodStock : baseForm
    {
        public viewFoodStock()
        {
            InitializeComponent();
            comboBox1.SelectedIndex = 0;
            loadFoodStock();
        }

        private void loadFoodStock()
        {
            dataGridView1.Rows.Clear();
            int i = 1;

            if (comboBox1.SelectedIndex == 0)
            {
                foreach (var a in data.foods)
                {
                    int outputpieces = data.productiondetails.Where(x => x.foodid.Equals(a.foodid)).Sum(x => x.productionoutputqty);

                    int sellingpieces = data.sellingdetails.Where(x=>x.foodid.Equals(a.foodid)).Sum(x=>x.qty);

                    dataGridView1.Rows.Add(i, a.foodname, a.productiondetails.Select(x => x.batchnumber).First(), a.productiondetails.Select(x => x.productionheader.productiondate).First(), a.productiondetails.Select(x => x.expireddate).First(), outputpieces - sellingpieces, a.status);
                    i++;
                }
            }
            else if (comboBox1.SelectedIndex == 2)
            {
                foreach (var a in data.foods)
                {
                    try
                    {
                        int outputpieces = data.productiondetails.Where(x => x.foodid.Equals(a.foodid) && x.expireddate <= DateTime.Now).Sum(x => x.productionoutputqty);

                        int sellingpieces = data.sellingdetails.Where(x => x.foodid.Equals(a.foodid)).Sum(x => x.qty);

                        var count = a.productiondetails.Where(x => x.expireddate <= DateTime.Now).Count();

                        if (count > 0)
                        {
                            dataGridView1.Rows.Add(i, a.foodname, a.productiondetails.Select(x => x.batchnumber).First(), a.productiondetails.Select(x => x.productionheader.productiondate).First(), a.productiondetails.Select(x => x.expireddate).First(), outputpieces, a.status);
                            i++;
                        }
                    }
                    catch (Exception ex)
                    {
                        continue;
                    }
                }
            }
            else
            {
                foreach (var a in data.foods)
                {
                    int outputpieces = data.productiondetails.Where(x => x.foodid.Equals(a.foodid)).Sum(x => x.productionoutputqty);

                    int sellingpieces = data.sellingdetails.Where(x => x.foodid.Equals(a.foodid)).Sum(x => x.qty);

                    var count = a.productiondetails.Where(x => x.expireddate <= DateTime.Now).Count();

                    if (count <= 0)
                    {
                        dataGridView1.Rows.Add(i, a.foodname, a.productiondetails.Select(x => x.batchnumber).First(), a.productiondetails.Select(x => x.productionheader.productiondate).First(), a.productiondetails.Select(x => x.expireddate).First(), outputpieces - sellingpieces, a.status);
                        i++;
                    }
                }
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            loadFoodStock();
        }
    }
}
