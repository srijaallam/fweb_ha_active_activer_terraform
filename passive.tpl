config system ha
    set mode active-active-high-volume
    set group-name activeactive
    set group-id 1
    set priority 5
    set tunnel-local ${passiveport2}
    set tunnel-peer ${activeport2}
    set monitor port2
end