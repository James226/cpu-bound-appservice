using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace Sleeper.Api
{
    public class Startup
    {
        public void ConfigureServices(IServiceCollection services)
        {
        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseRouting();

            app.Run(async r =>
            {
                for (var i = 0; i < 10; i++)
                {
                    await Task.Delay(TimeSpan.FromMilliseconds(20));
                    for (var j = 0; j < 20000; j++)
                    {
                        Thread.SpinWait(1);
                    }
                    Thread.Sleep(TimeSpan.FromMilliseconds(40));
                }
                r.Response.StatusCode = 200;
                await r.Response.WriteAsync("Success v5 (.net 5 Bullseye)");
            });
        }
    }
}
