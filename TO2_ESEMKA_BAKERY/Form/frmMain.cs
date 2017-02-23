using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TO2_ESEMKA_BAKERY.View;

namespace TO2_ESEMKA_BAKERY
{
    public partial class frmMain : Form
    {
        int employeeId;
        public frmMain(int employeeId)
        {
            InitializeComponent();
            this.WindowState = FormWindowState.Maximized;
            this.employeeId = employeeId;
        }

        private void loadLogin()
        {
            loginView l = new loginView();
            l.MdiParent = this;
            l.Show();
        }

        private void sellingToolStripMenuItem_Click(object sender, EventArgs e)
        {
            changePassword c = new changePassword(this.employeeId);
            c.MdiParent = this;
            c.WindowState = FormWindowState.Maximized;
            c.Show();
        }

        private void cashFlowToolStripMenuItem_Click(object sender, EventArgs e)
        {
            viewCashFlow c = new viewCashFlow();
            c.MdiParent = this;
            c.WindowState = FormWindowState.Maximized;
            c.Show();
        }

        private void logoutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Hide();
            loginView v = new loginView();
            v.ShowDialog();
        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Environment.Exit(1);
        }

        private void inputSellingToolStripMenuItem_Click(object sender, EventArgs e)
        {
            addSelling l = new addSelling(this.employeeId);
            l.MdiParent = this;
            l.WindowState = FormWindowState.Maximized;
            l.Show();
        }

        private void viewSellingToolStripMenuItem_Click(object sender, EventArgs e)
        {
            viewSelling l = new viewSelling();
            l.MdiParent = this;
            l.WindowState = FormWindowState.Maximized;
            l.Show();
        }

        private void addProductionToolStripMenuItem_Click(object sender, EventArgs e)
        {
            addProduction l = new addProduction();
            l.MdiParent = this;
            l.WindowState = FormWindowState.Maximized;
            l.Show();
        }

        private void viewProductionToolStripMenuItem_Click(object sender, EventArgs e)
        {
            viewProduction l = new viewProduction();
            l.MdiParent = this;
            l.WindowState = FormWindowState.Maximized;
            l.Show();
        }

        private void addIncomingRawMaterialToolStripMenuItem_Click(object sender, EventArgs e)
        {
            addIncomingRawMaterial l = new addIncomingRawMaterial();
            l.MdiParent = this;
            l.WindowState = FormWindowState.Maximized;
            l.Show();
        }

        private void viewIncomingRawMaterialToolStripMenuItem_Click(object sender, EventArgs e)
        {
            viewIncomingRawMaterial l = new viewIncomingRawMaterial();
            l.MdiParent = this;
            l.WindowState = FormWindowState.Maximized;
            l.Show();
        }

        private void viewFoodStockToolStripMenuItem_Click(object sender, EventArgs e)
        {
            viewFoodStock l = new viewFoodStock();
            l.MdiParent = this;
            l.WindowState = FormWindowState.Maximized;
            l.Show();
        }

        private void viewRawMaterialStockToolStripMenuItem_Click(object sender, EventArgs e)
        {
            viewRawMaterialStock l = new viewRawMaterialStock();
            l.MdiParent = this;
            l.WindowState = FormWindowState.Maximized;
            l.Show();
        }

        private void employeeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            addEmployee l = new addEmployee();
            l.MdiParent = this;
            l.WindowState = FormWindowState.Maximized;
            l.Show();
        }

        private void recipeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            addRecipe l = new addRecipe(this.employeeId);
            l.MdiParent = this;
            l.WindowState = FormWindowState.Maximized;
            l.Show();
        }

        private void foodToolStripMenuItem_Click(object sender, EventArgs e)
        {
            addFood l = new addFood();
            l.MdiParent = this;
            l.WindowState = FormWindowState.Maximized;
            l.Show();
        }

        private void rawMaterialToolStripMenuItem_Click(object sender, EventArgs e)
        {
            addRawMaterial l = new addRawMaterial(this.employeeId);
            l.MdiParent = this;
            l.WindowState = FormWindowState.Maximized;
            l.Show();
        }
    }
}
