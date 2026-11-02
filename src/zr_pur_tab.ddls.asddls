@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZPUR_TAB'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_PUR_TAB
  as select from zpur_tab
{
  key autoinc as Autoinc,
  purnum as Purnum,
  purname as Purname,
  purcreadate as Purcreadate,
  qty as qty,
  price as price,
  total as total,
  qty1 as qty1,
  price1 as price1,
  total1 as total1,
  @Semantics.user.createdBy: true
  createdby as Createdby,
  @Semantics.systemDateTime.createdAt: true
  createdat as Createdat,
  @Semantics.user.localInstanceLastChangedBy: true
  changedby as Changedby,
  @Semantics.systemDateTime.lastChangedAt: true
  lastchangedat as Lastchangedat,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  locallastchangedat as Locallastchangedat
}
