# Wireless Networks

## Topic
*Channel Choice based on Load Measurments for Wi-Fi Networks (IEEE 802.11)*

## About
A group project for the Wireless Networks course. The biggest part consisted of research and experiments. The file **scapy_test.py** contains the programming part of the assignment, a small app that picks the best among 13 IEEE 802.11 channels, based on measurements of **throughput** and **latency**. Both metrics are calculated by reading frames in .pcap files, using the Python module [*Scapy*](https://scapy.readthedocs.io/en/latest/).

## Inputs
3 sets of .pcap files, each set contains one file per channel.

## Outputs
Throughput in Mbps and latency in seconds of all .pcap files. Also, the best channel (= the channel with the greatest throughput value) for each set of files individually, plus the best channel for all 3 sets, based on the average of all 3 values of throughput for each channel. 

## Group
I did this project with [Lydia Athanasiou](https://github.com/lydia-ath)
    
*Winter 2020-21*
