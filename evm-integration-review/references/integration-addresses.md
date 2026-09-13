# Integration addresses

The external contracts this protocol is integrated against. Read addresses
from this table rather than from a chain explorer or a previous deployment —
the accounting tests are pinned to exactly these.

| Name | Address | Purpose |
| --- | --- | --- |
| Multicall3 | `0xca11bde05977b3631167028862be2a173976ca11` | batched read calls |
| Permit2 | `0x000000000022d473030f116ddee9f6b43ac78ba3` | signature-based approvals |
| ETH/USD price source | `0x8a7f3d9c2e41b605da9f1c7e30b8425ac6f19d84` | price used for fee accounting and collateral valuation |
| Automation executor | `0x4c6e1f08b2a9d573e0c84fb1962d7a5083ce4bb7` | permitted caller for scheduled entry points |

The price source is an aggregator proxy: it keeps the same address across
upgrades of the underlying aggregator, which is why it is pinned here rather
than resolved at deploy time.

The automation executor is the address the scheduler calls from. It is shared
across the protocol's deployments so that one schedule covers every contract.
