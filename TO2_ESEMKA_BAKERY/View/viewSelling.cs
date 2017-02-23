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
    public partial class viewSelling : baseForm
    {
        public viewSelling()
        {
            InitializeComponent();
            loadSelling();
        }

        private void loadSelling()
        {
            dataGridView1.Rows.Clear();

            int i = 1;
            foreach (var a in data.sellingheaders)
            {
                dataGridView1.Rows.Add(i, a.sellingid, a.sellingdate, a.sellingdetails.Sum(x=>x.qty), a.discount, a.sellingdetails.Sum(x=>x.price*x.qty), a.employee.employeename);
                i++;
            }
        }

        int headerIndex;
        int detailIndex;

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            headerIndex = e.RowIndex;
            if (dataGridView1.Columns[e.ColumnIndex].Name == "ShowDetail")
            {
                loadDetailSelling(int.Parse(dataGridView1.Rows[headerIndex].Cells[1].Value.ToString()));
            }
        }

        private void loadDetailSelling(int incomingid)
        {
            dataGridView2.Rows.Clear();
            int i = 1;
            foreach (var a in data.sellingdetails.Where(x => x.sellingid.Equals(incomingid)))
            {
                dataGridView2.Rows.Add(i, a.food.foodname, a.qty, a.price, a.price*a.qty);
                i++;
            }
        }
    }
}
