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
    public partial class viewProduction : baseForm
    {
        public viewProduction()
        {
            InitializeComponent();
            loadProduction();
        }

        private void loadProduction()
        {
            dataGridView1.Rows.Clear();

            int i = 1;
            foreach (var a in data.productionheaders)
            {
                dataGridView1.Rows.Add(i, a.productionid, a.productiondate, a.description, a.employee.employeename, a.status);
                i++;
            }
        }

        int headerIndex;

        private void viewProduction_Load(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            headerIndex = e.RowIndex;
            try
            {
                if (dataGridView1.Columns[e.ColumnIndex].Name == "ShowDetail")
                {
                    loadDetailProduction(int.Parse(dataGridView1.Rows[headerIndex].Cells[1].Value.ToString()));
                }
            }
            catch (Exception ex) { }
        }

        private void loadDetailProduction(int incomingid)
        {
            dataGridView2.Rows.Clear();
            int i = 1;
            foreach (var a in data.productiondetails.Where(x => x.productionid.Equals(incomingid)))
            {
                dataGridView2.Rows.Add(i, a.batchnumber, a.food.foodname, a.expireddate, a.productionoutputqty);
                i++;
            }
        }
    }
}
