#!/bin/sh

echo "Memory Usage"
cat /sys/fs/cgroup/memory/memory.usage_in_bytes
echo "Memory Limit"
cat /sys/fs/cgroup/memory/memory.limit_in_bytes
echo "CPU Quota"
cat /sys/fs/cgroup/cpu/cpu.cfs_quota_us
echo "CPU Period"
cat /sys/fs/cgroup/cpu/cpu.cfs_period_us
echo "CPU Usage"
cat /sys/fs/cgroup/cpu/cpuacct.usage

dotnet Sleeper.Api.dll