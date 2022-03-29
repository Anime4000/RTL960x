# UART
With TTL-UART make troubleshoot uncomplicated!

| SoC         | Total Pin | RX Pin | TX Pin |
|-------------|-----------|--------|--------|
| `RTL9601CI` | `76`      | `13`   | `12`   |
| `RTL9601D`  | `88`      | `16`   | `15`   |

For `GND` and `VCC` (3.3) you need **SFP Breakout Board** to power it via external source, TTL-UART (`CP210x`) not enough power!

If you unable to get **SFP Breakout Board**, you can get [SFP Seat (without cage)](https://www.aliexpress.com/item/1005001701209420.html) and power that way.

To avoid solder XPON Stick, use [**Flying Probe**](https://www.aliexpress.com/item/1005002848489450.html) to connect tiny pin into tiny pad.

# Credits
Thank you to [@stich86](https://github.com/stich86), [@tdmadam](https://github.com/tdmadam), [@manias21](https://github.com/manias21) for finding UART pin and testing!
