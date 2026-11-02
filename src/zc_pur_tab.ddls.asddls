@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZPUR_TAB'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_PUR_TAB
  provider contract transactional_query
  as projection on ZR_PUR_TAB
  association [1..1] to ZR_PUR_TAB as _BaseEntity on $projection.Autoinc = _BaseEntity.Autoinc
{
  key Autoinc,
  Purnum,
  Purname,
  Purcreadate,
  qty,
  price,
  total,
  qty1,
  price1,
  total1,
  @Semantics: {
    user.createdBy: true
  }
  Createdby,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  Createdat,
  @Semantics: {
    user.localInstanceLastChangedBy: true
  }
  Changedby,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  Lastchangedat,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  Locallastchangedat,
  _BaseEntity
}
