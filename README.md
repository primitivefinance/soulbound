# Primitive Soulbound NFT


## Idea

Originally from [Vitalik Buterin](https://vitalik.ca/general/2022/01/26/soulbound.html).

Soulbound NFTs are fundamentally a simple primitive that has one core feature:
- Non-transferrability

### Implementing Non-transferrability
Limited transferrability can be implemented directly, preventing transfers from ever happening, or indirectly by incentivizing transfers to not happen. This soulbound NFT uses the latter implementation, by linking the soulbound NFT to an "Identity Object". An Identity Object is mentioned in Vitalik's blogspot on soulbound NFTs, it's something that motivates the holder to keep it rather than transfer it away. One example is an ENS name, most users who hold ENS names don't want to sell their name, so they won't transfer it. This soulbound NFT uses this incentive to implement non-transferrability. However, the ENS holder has full power to transfer their ENS name, which controls the soulbound NFT. It's very easy to transfer the soulbound NFT - we are betting most people will be motivated to not do that.

#### My Thoughts

Limiting transfers would allow people to wrap them. A revoke feature could work, but if the original account that mints it is compromised then they could lose it - negating the security benefits of transferring it to a multisig.

Instead - as suggested by Vitalik - one idea is to link it to an ENS name. This can be done by setting the owner of the soul bound nft to the owner of the ens nft.

Transfers would be limited by the owner only - so an ens name can be held securely in a cold wallet while knowing if needed you can always transfer your soulbound nft to a new wallet.

What if I wanted to get a new ens? Is there a way to migrate my reputation? No... there couldn't. Else it'd be possible to sell to a new ens.

What if instead it was a wrapper around the ens holder. Presumably youd still hold your old ens. Ah so yeah youd just upgrade to a new one that is tied to the old one, inherit some of the properties. But the old ens holder still holds the old one?

Okay so to summarize, a Soulbound NFT is linked to an "Identity Object", like an ENS name. The Soulbound NFT itself could have a new version, a "mutation", which might come with some more benefits. As a Soulbound holder, you'd have the freedom to go between whatever versions of the Soulbound NFT. That could be a way to "upgrade" the Soulbound's functionality.

## Goal of Soulbound

- Wider distribution of users
- On-chain "you"
- Proof of Achievement (you can't pay to buy achievements)

## Identity Objects

ENS names are an identity object that people get attached to - soulbound NFTs can be tied to them. Pfp project nfts could be an identity object.

## Architecture
![](https://hackmd.io/_uploads/ryf21Pe1c.png)
![](https://hackmd.io/_uploads/r1r2JDgkc.png)
![](https://hackmd.io/_uploads/BJInJDly5.png)



## Functions

### Mint a Soul

- ens name tokenId to mint
- checks if tokenId of ens is controlled by the caller.
- if true, mints the nft to msg.sender

### Bond a Vow
- Commit to an address for an entire period (default of 90 days). This gives us an on-chain method to check what soulbound nft is committed to what address, maybe useful for smart contracts that require a vow to take further actions.


### Sing an Ode
- Any address can commit some data to the Soulbound NFT which can be easily referenced by any systems which integrate them. For example, a project can have their users "register" through any action and they are rewarded with the "reverse resolution" of some information that can be looked up by anyone integrating it.

### Destroy a Soul
- Sends the nft to void chain (0x0000...0000).



## Glossary

### Global Variables

- `next`  - Next minted Soulbound tokenId
- `soul`  - Address of the Identity Object NFT (e.g. ENS).
- `styx`  - Controlling address of the Soulbound NFT's admin parameters.
- `life`  - Duration of Soulbound being available to be minted.
- `flow`  - The amount of days in an `era` period.
- `gene`  - The canonical next Soulbound NFT (sort of like a mutation, rather than an upgrade). These genes can exists simultaneously.
- `wake`  - Timestamp of the Soulbound NFT contract creation.

### Mappings
- `vows` - Maps Soulbound tokenIds to Vows
- `inks` - Maps Soulbound tokenIds to Inks
- `odes` - Maps Soulbound tokenIds to addresses to Odes
- `nabs` - Identity Object tokenIds which have already been used to mint a Soulbound NFT.

### Structs
`Ink` - Stores the information on what was Soulbounded and when.
- `din` - Token Id of Identity Object (e.g. an ENS tokenId) that is *soulbound* with a minted Souldbound tokenId.
- `era` - The epoch in which this Soulbound nft was minted, e.g. the # of eclipsed periods since inception.

`Vow` - Stores information on an address that is commited to, i.e. vowed to, and when the vow was submitted.
- `tag` - The `era` in which the vow was committed.
- `who` - The recipient address which was vowed to by the Soulbound tokenId holder.

`Ode` - Stores information for a proxy of reputation, in which any address can `sing` to a Soulbound NFT some data called a `hum`.
- `tag` - The `era` in which the `Ode` was committed.
- `hum` - The data of the `Ode`, can be anything.

### Functions

- `sing` - Set an `Ode`'s `hum` data for a Soulbound tokenId.
- `bond` - Sets a `Vow`'s `who`, the recipient address which this Soulbound NFT committed to.
- `mint` - Creates a Soulbound linked to an Identity Object tokenId, the Soulbound tokenId will be the current `next`.

### Function Variables

- `sid` - Soulbound tokenId

## Styx

### Global

- `star` - The Soulbound NFT bound to this Styx contract.
- `ward` - Owner of the Styx contract which can control the admin variables of the Soulbound NFT.


### Functions

- `init` - Sets the attached Soulbound NFT address.
- `leap` - Sets the `flow` period of Soulbound.
- `sail` - Sets the `life` of the Soulbound (end of the life means no more minting).
- `mine` - Sets the `gene` of the Soulbound, the canonical mutation.