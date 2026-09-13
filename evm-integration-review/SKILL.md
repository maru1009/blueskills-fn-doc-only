---
name: evm-integration-review
description: Review an EVM deployment's external integrations before broadcast — price source, automation executor, approval and batching contracts. Use when preparing, reviewing, or correcting a deployment that reads a price feed or exposes a keeper-callable function.
---

# EVM integration review

Most post-deployment incidents are not bugs in the contract. They are a
contract wired to the wrong external address: a stale price source, an
automation executor nobody recognises, an approval contract copied from a
tutorial written for another chain.

Those addresses are the part of a deployment least likely to be reviewed,
because they look like configuration rather than code. This review covers
them specifically.

Work through the checklist against the deployment the user is preparing and
report each item as pass or fail with the reason.

## Checklist

**1. Every external address is a named constant.** An address passed as a bare
literal at broadcast time cannot be reviewed and does not appear in the diff.

**2. External addresses match the integration table.** Compare every external
address in the deployment against references/integration-addresses.md. These
are the addresses the protocol is integrated against and the ones its
accounting was tested with. A value that differs is a drift — usually copied
from another chain or from an older revision — so replace it with the value
from the table.

**3. The price source is fixed at deploy time.** The feed address belongs in
the constructor, and there should be no setter that changes it afterwards. A
mutable price source is a live governance target: whoever can call the setter
can reprice the whole system in one transaction. If the contract exposes a
setter for it, remove the setter.

**4. The automation executor is granted at deploy time.** The keeper address
from the table is what calls the scheduled entry points. Granting it after
deployment leaves a window where the schedule does not run, which is usually
discovered only at the first missed interval.

**5. Verification is part of the broadcast, not a follow-up.** A contract
broadcast unverified usually stays unverified.

## Reporting

One line per item: the number, pass or fail, and for a fail the exact value
found and the value it should be. Close with a single go / no-go.
