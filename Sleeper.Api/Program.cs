using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace Sleeper.Api
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var threads = int.Parse(Environment.GetEnvironmentVariable("THREADS") ?? "2");
            for (var i = 0; i < threads; i++)
            {
                new Thread(() =>
                {
                    while(true){}
                }).Start();
            }
            CreateHostBuilder(args).Build().Run();
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStartup<Startup>();
                });
    }
}
