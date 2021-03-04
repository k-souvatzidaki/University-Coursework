from scapy.all import *

#Input: a .pcap capture file
#Output: Mbytes, Latency in sec and Throughput in Mbps
def read_pcap(pcapfile): 

    frames = rdpcap(pcapfile,-1)
    capture_time = round((frames[len(frames)-1].time - frames[0].time),2)  #latency in seconds

    #find total bytes and payload bytes
    total_bytes = 0
    payload_bytes = 0
    for frame in frames:
        total_bytes = total_bytes + len(frame)
        payload_bytes = payload_bytes + len(bytes(frame.payload))
  
    total_mbytes = round(total_bytes * pow(10,-6),2)
    payload_mbytes = round(payload_bytes * pow(10,-6),2)

    #convert to bits
    total_bits = total_bytes * 8
    payload_bits = payload_bytes * 8
    #calculate Mbps
    bps = total_bits / capture_time
    total_mbps = round(bps * pow(10,-6),2)

    pbps = payload_bits / capture_time
    payload_mbps = round(pbps * pow(10,-6),2)

    #return
    return total_mbytes, payload_mbytes, capture_time, total_mbps,payload_mbps

def main(): 
    path = "Experiment 1/"

    #total results
    max_mbps, max_channel = 0,0
    min_latency = sys.maxint
    min_channel = 0
    
    #result per test
    max_test = [0,0,0]
    max_test_channel = [0,0,0]
    min_test = [sys.maxint, sys.maxint, sys.maxint]
    min_test_channel = [0,0,0]


    #for all channels, read the pcap files
    for channel in range(1,14): 
        sum_mbps = 0
        sum_latency = 0
        channel_path = path+ str(channel)
        print ("Channel "+str(channel))
        for pcap_num in range (1,4):
            pcap_file = channel_path+"/"+str(pcap_num)+".pcap"
            total_mbytes, payload_mbytes, capture_time, total_mbps, payload_mbps = read_pcap(pcap_file)
            sum_mbps = sum_mbps + payload_mbps
            sum_latency = sum_latency + capture_time
            #print results
            print("Test #"+str(pcap_num)+": \t Total Mbytes: "+str(total_mbytes)+"\t Payload Mbytes: "+ str(payload_mbytes)+"\t Latency(sec): " 
                  + str(capture_time)+ "\t Total Mbps: " +str(total_mbps)+"\t Payload Mbps: "+str(payload_mbps))
        
            if(payload_mbps > max_test[pcap_num-1]):
                max_test[pcap_num-1] = payload_mbps
                max_test_channel[pcap_num -1] = channel
            if(capture_time < min_test[pcap_num-1]):
                min_test[pcap_num-1] = capture_time
                min_test_channel[pcap_num -1] = channel

        avg_mbps = round(sum_mbps / 3 ,2)
        avg_latency = round(sum_latency / 3 ,2)
        print("Average Mbps: "+ str(avg_mbps)+"\t Average Latency: "+ str(avg_latency))
        print
        if(avg_latency < min_latency):
            min_channel = channel
            min_latency = capture_time
        if(avg_mbps > max_mbps):
            max_channel = channel
            max_mbps = payload_mbps

    print
    #printing total results per test
    for test in range(0,3):
        print("The Channel with the greatest Throughput in Test #"+str(test+1)+" is Channel "+ str(max_test_channel[test]) +": "+str(max_test[test]))
        print("The Channel with the smallest Latency in Test #"+str(test+1)+"  is Channel "+ str(min_test_channel[test]) +": "+str(min_test[test]))
    print
    #printing total average results
    print("The Channel with the greatest average Throughput is Channel "+ str(max_channel) +": "+str(max_mbps))
    print("The Channel with the smallest average Latency is Channel "+ str(min_channel) +": "+str(min_latency))
            

main() 