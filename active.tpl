config system ha
    set mode active-active-high-volume
    set group-name activeactive
    set group-id 1
    set priority 2
    set tunnel-local ${activeport2}
    set tunnel-peer ${passiveport2}
    set monitor port2
end

