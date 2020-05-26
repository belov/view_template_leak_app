# Examlpe using prepend_view_path in before_action

ubuntu 14.04.

ruby 2.2.2

## Setup
bundle

RAILS_ENV=production rake db:migrate

## Run

run 2 instance aplication:

 bundle exec unicorn_rails -E production -p 3000 
 
 bundle exec unicorn_rails -E production -p 3300 


## Test

Simple render: 

 ab -n 50000 http://localhost:3000/ 

Render using prepend_view_path in before_action: 

 ab -n 50000 http://localhost:3300/?mobile=true 


## Results

````
Server Hostname:        localhost
Server Port:            3000

Document Path:          /
Document Length:        817 bytes

Concurrency Level:      1
Time taken for tests:   233.832 seconds
Complete requests:      50000
Failed requests:        0
Total transferred:      78100000 bytes
HTML transferred:       40850000 bytes
Requests per second:    213.83 [#/sec] (mean)
Time per request:       4.677 [ms] (mean)
Time per request:       4.677 [ms] (mean, across all concurrent requests)
Transfer rate:          326.17 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       4
Processing:     3    5   1.7      4      37
Waiting:        3    4   1.6      4      37
Total:          3    5   1.7      4      37

Percentage of the requests served within a certain time (ms)
  50%      4
  66%      5
  75%      5
  80%      6
  90%      7
  95%      8
  98%      9
  99%     10
 100%     37 (longest request)

````

````
Server Hostname:        localhost
Server Port:            3300

Document Path:          /?mobile=true
Document Length:        840 bytes

Concurrency Level:      1
Time taken for tests:   493.722 seconds
Complete requests:      50000
Failed requests:        0
Total transferred:      79250000 bytes
HTML transferred:       42000000 bytes
Requests per second:    101.27 [#/sec] (mean)
Time per request:       9.874 [ms] (mean)
Time per request:       9.874 [ms] (mean, across all concurrent requests)
Transfer rate:          156.75 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       1
Processing:     7   10   2.9      9      53
Waiting:        7   10   2.8      9      52
Total:          7   10   2.9      9      53

Percentage of the requests served within a certain time (ms)
  50%      9
  66%     11
  75%     11
  80%     12
  90%     13
  95%     15
  98%     17
  99%     20
 100%     53 (longest request)

````


````
                VIRT   RES
 5358  8.1  0.9 190328 76640  pts/8    Sl+  00:04   3:40 unicorn_rails worker[0] -E production -p 3000
 5367 17.7  2.7 333608 219908 pts/7    Sl+  00:04   8:00 unicorn_rails worker[0] -E production -p 3300

````

## Long test results

run app:

bundle exec unicorn_rails -E production -p 3300 

run ab:

````
ab -n 50000000 http://localhost:3300/?mobile=true 
This is ApacheBench, Version 2.3 <$Revision: 1528965 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient)
^C

Server Software:        
Server Hostname:        localhost
Server Port:            3300

Document Path:          /?mobile=true
Document Length:        960 bytes

Concurrency Level:      1
Time taken for tests:   15717.540 seconds
Complete requests:      1653794
Failed requests:        0
Total transferred:      2819718770 bytes
HTML transferred:       1587642240 bytes
Requests per second:    105.22 [#/sec] (mean)
Time per request:       9.504 [ms] (mean)
Time per request:       9.504 [ms] (mean, across all concurrent requests)
Transfer rate:          175.19 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       6
Processing:     6    9  16.5      8    1303
Waiting:        2    9  16.4      7    1303
Total:          6    9  16.5      8    1303

Percentage of the requests served within a certain time (ms)                                                                                                                                            
  50%      8                                                                                                                                                                                            
  66%      8                                                                                                                                                                                            
  75%      9                                                                                                                                                                                            
  80%     10                                                                                                                                                                                            
  90%     12                                                                                                                                                                                            
  95%     14                                                                                                                                                                                            
  98%     16                                                                                                                                                                                            
  99%     18
 100%   1303 (longest request)

````
run by cron command:

````
* * * * *  ps -axo rss,vsz,pid,args | grep unicorn | grep master | grep -v ps >> ~/mem_log_master
````

### Results in files
* mem_log_worker
* mem_log_master

### Chart:

mem_log_worker.ods

![GitHub Logo](https://github.com/belov/view_template_leak_app/blob/master/mem_log_worker.png)

