# No-QAnon

An anti-fascist domains blocklist of QAnon, conspiracy, fake news, far-right and hateful websites.

By blocking the websites linked to hate groups and bad actors, it aims to defuse recruitment, propaganda and slow the spread of disinformation via tactics such as psyops, astroturfing, trolls, false flags, sockpuppeting, stochastic terrorism, FUD, etc.

A domains blocklist only blocks entire websites: it's unfortunately unable to block anything on social media where radicalization often happens due to poor or complicit moderation.
It will still definitely reduce exposition to false and harmful informations.
Fascists prey on the vulnerable so stay vigilant and consider also using a social media blocklist if needed.

Distributed under the [anti-fascist licence](https://github.com/rimu/no-qanon/blob/master/LICENSE.txt).

## DNS blockers

### Hosts format

[Blocklist in Hosts format](https://raw.githubusercontent.com/rimu/no-qanon/master/hosts.txt) to use in a [hosts](https://en.wikipedia.org/wiki/Hosts_(file)) file or or [Pi-hole](https://pi-hole.net/).

[IPV6 version](https://raw.githubusercontent.com/rimu/no-qanon/master/hosts.txt.ipv6).

- [How to install on a Windows computer.](https://github.com/yui-konnu/qanon-block-guide)

- [How to install on a Pi-hole.](https://www.reddit.com/r/QAnonCasualties/comments/wekhem/how_to_use_pihole_to_block_q_related_websites/)

**Known issue:** [Firefox's DNS over HTTPS option bypasses the computer's hosts file ruleset.](https://bugzilla.mozilla.org/show_bug.cgi?id=1453207)

### Dnsmasq format

[Blocklist in Dnsmasq format](https://raw.githubusercontent.com/rimu/no-qanon/master/dnsmasq.txt) to use with the [Dnsmasq](https://thekelleys.org.uk/dnsmasq/doc.html) DNS server software.

## Browser extensions

### Netsane format

[Blocklist in Netsane format](https://raw.githubusercontent.com/rimu/no-qanon/master/netsane.txt) to use with the [Netsane](https://github.com/rimu/netsane) software.

### AdBlock Plus syntax

[Blocklist in AdBlock format](https://raw.githubusercontent.com/rimu/no-qanon/master/adblock.txt) to use with an adblocker ([uBlock Origin](https://ublockorigin.com), [Adguard](https://adguard.com)…) or Adguard Home. It uses a [strict blocking rule](https://github.com/gorhill/uBlock/wiki/Strict-blocking) to block access to those sites on your browser.

[Click here to subscribe.](https://subscribe.adblockplus.org/?location=https://raw.githubusercontent.com/rimu/no-qanon/master/adblock.txt&title=No-QAnon)

### uBlacklist syntax

[Blocklist in uBlacklist format](https://raw.githubusercontent.com/rimu/no-qanon/master/ublacklist.txt) to use with [uBlacklist](https://github.com/iorate/ublacklist). It removes blocked sites from search engine results.

[Click here to subscribe.](https://iorate.github.io/ublacklist/subscribe?name=No-QAnon&url=https://raw.githubusercontent.com/rimu/no-qanon/master/ublacklist.txt) (This automatic subscription link is only compatible with Chrome, you have to add it by yourself on other browsers!)

## Fediverse formats

### Mastodon

[Blocklist in Mastodon format](https://raw.githubusercontent.com/rimu/no-qanon/master/mastodon.csv) to use with [Mastodon](https://joinmastodon.org/) and other federated services. It will defederate from blocked instances.

### Fediblockhole

[Blocklist in FediBlockHole format](https://raw.githubusercontent.com/rimu/no-qanon/master/fediblockhole.csv) to use with the [FediBlockHole](https://github.com/eigenmagic/fediblockhole) tool for Mastodon. It will defederate from blocked instances.

## How to contribute

Clone this repository and add one domain per line in `.txt` files stored in the `sources` folder. Blocked sites are organized using subfolders and `.txt` files within the `sources` folder. Use comments (`#`) and markdown files (`.md`) to add more information and references.

> For the `https://www.example.com` website, add `example.com` on a new line of the `sources/default.txt` file.

You can paste the full URL: the update script will clean it and make it a domain. As the hosts format does not automatically block subdomains (e.g. `subdomain.example.com`), they have to be explicitely added to the list to maintain compatibility.

It is possible to add TLDs (e.g. `com`, without the dot) to the list, they will be blocked by Dnsmasq, adblockers and uBlacklist. Domains related to Fediverse instances (Mastodon, Peertube, etc.) should be put in `.txt` files with `fediverse` in their names (e.g. `Bad Fediverse is bad.txt`) so that they are included in the Fediverse blocklists.

Then, when you push your changes to the `sources` folder, GitHub actions automatically generate new versions of the blocklists. Should you want to generate them yourself, you can run the `scripts/update.sh` script (prerequisites : bash, python).

Finally, make a pull request: it will be reviewed and approve it within a few days.

### Importing an external list

External lists can be imported by adding them to the `import/importlist.txt` as a new line in the following format: `list name.txt|url`. They are automatically downloaded twice a day, cleaned (some formats only), copied to the `sources/_imported/`folder and thus added to the list generation database. The domain list in the `import/allowlist.txt` file serves as an exception ruleset for imported lists.

### How to contribute (easy mode)

If you have no idea how Git works, you can still contribute! Just [open an issue](https://github.com/rimu/no-qanon/issues) with the URLs you would like to add to the list (or remove, false positives happen!), grouping them by language and categories if possible. We'll check and add them shortly.

## Aggregated lists

This blocklist borrows from the following projects:
- the [full blocklist](https://peertube_isolation.frama.io/list/peertube_isolation.txt) from [PeerTube Isolation](https://peertube_isolation.frama.io/) (no licence, free redistribution).
- the [Tabloid Remover blocklist](https://github.com/DandelionSprout/adfilt/blob/master/Sensitive%20lists/TabloidRemover.txt) and its [Mastodon extension](https://github.com/DandelionSprout/adfilt/blob/master/Sensitive%20lists/TabloidRemover-MastodonCategoryForImports.csv) from DandelionSprout's [adfilt](https://github.com/DandelionSprout/adfilt) ([Dandelicence](https://github.com/DandelionSprout/adfilt/blob/master/LICENSE.md)).
- the [fake local journals list](https://github.com/MassMove/AttackVectors/blob/master/LocalJournals/fake-local-journals-list.txt) from MassMove's [Attack Vectors](https://github.com/MassMove/AttackVectors/) ([MIT licence](https://github.com/MassMove/AttackVectors/blob/master/LICENSE)).
- the [fake news and clickbait list](https://assets.windscribe.com/custom_blocklists/clickbait.txt) from Windscribe's [R.O.B.E.R.T.](https://windscribe.com/features/robert) (no licence).
- the [fakenews list](https://github.com/StevenBlack/hosts/blob/master/alternates/fakenews-only/hosts) from StevenBlack's [Hosts](https://github.com/StevenBlack/hosts) ([MIT licence](https://github.com/StevenBlack/hosts/blob/master/license.txt)).
- the [default](https://github.com/antifa-n/pihole/blob/master/blocklist.txt), [right wing populistitc content](https://github.com/antifa-n/pihole/blob/master/blocklist-pop.txt), and [alt-tech platforms](https://github.com/antifa-n/pihole/blob/master/blocklist-alttech.txt) blocklists from antifa-n's [Pi-hole blocklists](https://github.com/antifa-n/pihole) ([GNU General Public License v3.0](https://github.com/antifa-n/pihole/blob/master/LICENSE)).
- the [full blocklist](https://github.com/AFNIL-AntiFakeNewsInternationalList/AFNIL/blob/master/hosts) from AFNIL-AntiFakeNewsInternationalList's [AFNIL](https://github.com/AFNIL-AntiFakeNewsInternationalList/AFNIL) ([GNU General Public License v3.0](https://github.com/AFNIL-AntiFakeNewsInternationalList/AFNIL/blob/master/LICENSE)).

## Other useful lists

[Jmdugan Blocklists](https://github.com/jmdugan/blocklists/tree/master/corporations): consider blocking platforms such as Twitter, YouTube and Facebook as they are riddled with fake news and fascist content.

[Bypass Methods Blocklist](https://github.com/nextdns/dns-bypass-methods) can be used to block bypass methods (VPNs, proxies, DNS, etc.).
