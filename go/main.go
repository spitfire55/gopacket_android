package main

import (
    "fmt"
    "github.com/google/gopacket"
    "github.com/google/gopacket/pcap"
    "log"
)

func main() {
    handle, err := pcap.OpenLive("wlan0", 65536, true, pcap.BlockForever)
    if err != nil {
        log.Fatal(err)
    }
    defer handle.Close()

    packetSource := gopacket.NewPacketSource(handle, handle.LinkType())
    counter := 0
    for packet := range packetSource.Packets() {
        fmt.Printf("Packet %d: %s\n", counter, packet.Dump())
        counter++
        if counter == 10 {
            break
        }
    }
}
