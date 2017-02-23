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
    public partial class viewIncomingRawMaterial : baseForm
    {
        public viewIncomingRawMaterial()
        {
            InitializeComponent();
            loadRawMaterial();
        }

        private void loadRawMaterial()
        {
            dataGridView1.Rows.Clear();

            int i = 1;
            foreach (var a in data.incomingrawmaterialheaders)
            {
                dataGridView1.Rows.Add(i, a.incomingrawmaterialid, a.incomingdate, a.description, a.employee.employeename);
                i++;
            }
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        int headerIndex;
        int detailIndex;

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            headerIndex = e.RowIndex;
            if (dataGridView1.Columns[e.ColumnIndex].Name == "ShowDetail")
            {
                loadDetailRawMaterial(int.Parse(dataGridView1.Rows[headerIndex].Cells[1].Value.ToString()));
            }
        }

        private void loadDetailRawMaterial(int incomingid)
        {
            dataGridView2.Rows.Clear();
            int i = 1;
            foreach (var a in data.incomingrawmaterialdetails.Where(x => x.incomingrawmaterialid.Equals(incomingid)))
            {
                dataGridView2.Rows.Add(i, a.rawmaterial.rawmaterialname, a.bestbeforedate, a.weightingram);
                i++;
            }
        }
    }
}
