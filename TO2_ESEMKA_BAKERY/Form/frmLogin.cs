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
    public partial class loginView : Form
    {
        selectiontestwsc2017Entities data = new selectiontestwsc2017Entities();

        public loginView()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            foreach (var a in this.Controls.OfType<TextBox>().Where(x => x.Text == ""))
            {
                MessageBox.Show("Please complete the form!");
                return;
            }

            var login = data.employees.Where(x => x.email.Equals(textBox1.Text) && x.password.Equals(textBox2.Text));

            if (login.Count() > 0)
            {
                this.Hide();
                frmMain m = new frmMain(login.Select(x => x.employeeid).First());
                m.ShowDialog();
            }
            else
            {
                MessageBox.Show("Email or Password wrong!");
                return;
            }
        }
    }
}
