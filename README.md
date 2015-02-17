# Jimdget

![Alt text](/Screenshots/jimdget_01.png?raw=true "Double graph view")
![Alt text](/Screenshots/jimdget_02.png?raw=true "Single graph view")

In order to make Jimdget run:

- Enable the 'App Groups' Capability on both (Jimdget & JMDStatsExtension) targets ans make sure they share a common container.
  In case entitlement generation fails go to the developer portal and add by hand.

- Before building the app or extension build the pods with the 'pods' target. If it's not visible enable it through 'Manage schemes'.


