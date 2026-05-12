# PhotonEsTuDios — Website

**Live:** https://www.photonestudios.com  
**Bucket:** `photonestudios-website` (AWS S3, eu-west-1)  
**CloudFront:** `E2AV0UKK8M6336`

## Für deine Claude-Session

Öffne das Terminal und sage Claude:

> "Lade den Kontext aus diesem Repo. Ich bin Daniela Haering, Artist Consultant in Granada. Ich möchte meine Website unter photonestudios.com bearbeiten und deployen. Mein AWS-Profil heißt `photon`."

Claude kann dann direkt:
- die `index.html` bearbeiten
- auf S3 deployen: `aws s3 cp index.html s3://photonestudios-website/ --profile photon`
- CloudFront Cache leeren: `aws cloudfront create-invalidation --distribution-id E2AV0UKK8M6336 --paths "/*" --profile photon`

## Setup (einmalig, Terminal)

```bash
# 1. AWS Credentials einrichten
aws configure --profile photon
# → Access Key ID & Secret Key aus der Datei auf dem Desktop

# 2. Dieses Repo klonen
git clone https://github.com/PhotonEsTuDios/website
cd website

# 3. Test: S3-Zugriff prüfen
aws s3 ls s3://photonestudios-website/ --profile photon
```

## Struktur

```
index.html      ← die gesamte Website (eine Datei, kein Framework)
```

## Deploy (nach Änderungen)

```bash
aws s3 cp index.html s3://photonestudios-website/ --profile photon
aws cloudfront create-invalidation \
  --distribution-id E2AV0UKK8M6336 \
  --paths "/*" \
  --profile photon
```

## Architektur

| Komponente | Details |
|---|---|
| Hosting | AWS S3 Static Website |
| CDN | AWS CloudFront (HTTPS, global) |
| Domain | Route53 → photonestudios.com |
| Region | eu-west-1 (Irland) |
| Passwort | `dani` (clientseitig, für Preview) |

---
*Gebaut von [IT Rockstars](https://www.it-rockstars.com) · in Zusammenarbeit mit [LaMusicaEsTuDios](https://www.lamusicaestudios.com)*
