# HSQL 인메모리 기동

별도 DB(MySQL 등) 설치 없이 HSQL 인메모리 DB로 애플리케이션을 기동/테스트할 수 있습니다.

## 사용 방법
`src/main/resources/egovframework/egovProps/globals.properties`:
```
Globals.DbType = hsql
Globals.Hsql.AutoInit = true
```
- `Globals.DbType=hsql` : 데이터소스를 HSQL 인메모리로 전환
- `Globals.Hsql.AutoInit=true` : 기동 시 `all_ebt_ddl_hsql.sql`(스키마)·`all_ebt_data_hsql.sql`(기초데이터) 자동 적재

## 비고
- HSQL은 기존 MySQL 매퍼 호환을 위해 `sql.syntax_mys=true` 모드로 동작하며, 매퍼는 `*_hsql.xml` 을 사용합니다.
- 인메모리이므로 기동 시 초기화되고 종료 시 데이터는 보존되지 않습니다.
- 운영 DB는 기존과 동일하게 `Globals.DbType` 변경만으로 사용하며 본 설정의 영향을 받지 않습니다.
