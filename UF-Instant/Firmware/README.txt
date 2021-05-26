This is a flash dump from a purchased Ubiquiti UFiber Instant (UF-Instant), not a firmware update package.
SSH is disabled in flash_all.xml, but enabled in order to dump the MTD block devices.

ssh ubnt@192.168.1.1 'cat /dev/mtd0' >dev_mtd0


    SN:         UBNT29F5C9ED
MAC ID: (2017C) 18E829F5C9ED


UART pins from front (SC) to back (SFP):
GND, VCC, Rx, Tx

