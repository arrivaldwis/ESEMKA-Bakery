using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace TO2_ESEMKA_BAKERY.Class
{
    public class Helpers
    {
        public bool isEmailValid(string email)
        {
            bool msg = false;

            try
            {
                string EMAIL = new MailAddress(email).Address;
                if (!EMAIL.EndsWith("."))
                {
                    if (!EMAIL.Contains("..") || !EMAIL.Contains("@.") || !EMAIL.Contains(".@") || !EMAIL.Contains("._.") || !EMAIL.Contains("_.") || !EMAIL.Contains("._"))
                    {
                        msg = true;
                    }
                }
            }
            catch (Exception ex)
            {
                msg = false;
            }

            return msg;
        }

        public bool isNumberValid(TextBox tb)
        {
            bool msg = true;
            if (tb.Text.Any(x => char.IsLetter(x)))
            {
                msg = false;
            }
            return msg;
        }
    }
}
