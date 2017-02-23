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
    public partial class viewRawMaterialStock : baseForm
    {
        public viewRawMaterialStock()
        {
            InitializeComponent();
            comboBox1.SelectedIndex = 0;
            loadRawMaterialStock();
        }

        private void loadRawMaterialStock()
        {
            dataGridView1.Rows.Clear();
            int i = 1;

            if (comboBox1.SelectedIndex == 0)
            {
                foreach (var a in data.rawmaterials)
                {
                    dataGridView1.Rows.Add(i, a.rawmaterialname, a.incomingrawmaterialdetails.Select(x => x.incomingrawmaterialheader.incomingdate).First(), a.incomingrawmaterialdetails.Select(x => x.bestbeforedate).First(), a.incomingrawmaterialdetails.Where(x => x.rawmaterialid.Equals(a.rawmaterialid)).Sum(x => x.weightingram) - a.rawmaterialintakes.Where(x => x.rawmaterialid.Equals(a.rawmaterialid)).Sum(x => x.weightingram));
                    i++;
                }
            }
            else if (comboBox1.SelectedIndex == 2)
            {
                foreach (var a in data.rawmaterials)
                {
                    var count = a.incomingrawmaterialdetails.Where(x => x.bestbeforedate <= DateTime.Now).Count();

                    if (count > 0)
                    {
                        dataGridView1.Rows.Add(i, a.rawmaterialname, a.incomingrawmaterialdetails.Select(x => x.incomingrawmaterialheader.incomingdate).First(), a.incomingrawmaterialdetails.Select(x => x.bestbeforedate).First(), a.incomingrawmaterialdetails.Where(x => x.rawmaterialid.Equals(a.rawmaterialid)).Sum(x => x.weightingram) - a.rawmaterialintakes.Where(x => x.rawmaterialid.Equals(a.rawmaterialid)).Sum(x => x.weightingram));
                        i++;
                    }
                }
            }
            else
            {
                foreach (var a in data.rawmaterials)
                {
                    var count = a.incomingrawmaterialdetails.Where(x => x.bestbeforedate <= DateTime.Now).Count();

                    if (count <= 0)
                    {
                        dataGridView1.Rows.Add(i, a.rawmaterialname, a.incomingrawmaterialdetails.Select(x => x.incomingrawmaterialheader.incomingdate).First(), a.incomingrawmaterialdetails.Select(x => x.bestbeforedate).First(), a.incomingrawmaterialdetails.Where(x => x.rawmaterialid.Equals(a.rawmaterialid)).Sum(x => x.weightingram) - a.rawmaterialintakes.Where(x => x.rawmaterialid.Equals(a.rawmaterialid)).Sum(x => x.weightingram));
                        i++;
                    }
                }
            }
        }

        private void viewRawMaterialStock_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            loadRawMaterialStock();
        }
    }
}
