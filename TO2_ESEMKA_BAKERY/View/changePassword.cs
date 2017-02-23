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
    public partial class changePassword : Form
    {
        int employeeId;
        public changePassword(int employeeId)
        {
            InitializeComponent();
            this.employeeId = employeeId;
        }
    }
}
