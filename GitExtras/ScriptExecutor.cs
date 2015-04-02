using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text.RegularExpressions;

namespace GitExtras
{
    class ScriptExecutor
    {
        static void Main(string[] args)
        {
            var scriptToExecute = Path.ChangeExtension(Assembly.GetExecutingAssembly().Location, "ps1");
            using (var process = new Process())
            {
                process.StartInfo = new ProcessStartInfo
                {
                    FileName = "powershell.exe",
                    Arguments = string.Format("-File \"{0}\" {1}", scriptToExecute, string.Join(" ", args.Select(a => EncodeParameterArgument(a)))),
                    UseShellExecute = false,
                };
                process.Start();
                process.WaitForExit();
            }
        }

        static string EncodeParameterArgument(string original)
        {
            if (string.IsNullOrEmpty(original))
                return original;
            string value = Regex.Replace(original, @"(\\*)" + "\"", @"$1\$0");
            value = Regex.Replace(value, @"^(.*\s.*?)(\\*)$", "\"$1$2$2\"");
            return value;
        }
    }
}
