# Spring Data MyBatis 
[![Build Status](https://travis-ci.org/hatunet/spring-data-mybatis.svg?branch=master)](https://travis-ci.org/hatunet/spring-data-mybatis)   [![Gitter chat](https://badges.gitter.im/gitterHQ/gitter.png)](https://gitter.im/spring-data-mybatis)


Spring Data 项目的主要目标是使构建使用数据访问技术的 Spring 应用程序变得更加容易。此模块处理增强基于 MyBatis 的数据访问层的支持。

通过使用此模块，你可以在基于MyBatis为ORM的结构下使用Spring Data模式带来的便利性。

如果你还没有接触过[Spring Data](http://projects.spring.io/spring-data/)，建议先了解下该[项目](http://projects.spring.io/spring-data/)。


## 支持的一些特性 ##

* 对标准Entity支持完整CRUD操作
* 支持通过接口中的方法名生成对应的查询
* 提供基础属性的实体基类
* 支持透明审计（如创建时间、最后修改)
* 自持自定义编写基于MyBatis的查询，方便而不失灵活性
* 方便的与Spring集成
* 支持MySQL、Oracle、SQL Server、H2、PostgreSQL等数据库


## 获得帮助 ##

这里有一份文档可以帮助你快速学习 Spring Data Mybatis。 [reference documentation](https://hatunet.github.io/spring-data-mybatis/)  

如果你有任何疑问或者建议，可以录一个[issue](https://github.com/hatunet/spring-data-mybatis/issues) 给我。

## 快速开始 ##

通过Maven引入依赖包:

```xml
<dependency>
  <groupId>com.ifrabbit</groupId>
  <artifactId>spring-data-mybatis</artifactId>
  <version>1.0.15.RELEASE</version>
</dependency>
```

如果你想使用快照版本:
```xml
<dependency>
  <groupId>com.ifrabbit</groupId>
  <artifactId>spring-data-mybatis</artifactId>
  <version>1.0.16.BUILD-SNAPSHOT</version>
</dependency>
```
使用快照版本前，需要在pom.xml中配置:

```xml
<repository>
 <id>oss-snapshots-repo</id>
 <url>https://oss.sonatype.org/content/repositories/snapshots</url>
 <releases><enabled>false</enabled></releases>
 <snapshots><enabled>true</enabled></snapshots>
</repository>
```


最简单的通过Java注解配置的Spring Data Mybatis 配置如下所示：
```java
@Configuration
@EnableMybatisRepositories(
        value = "org.springframework.data.mybatis.repository.sample",
        mapperLocations = "classpath*:/org/springframework/data/mybatis/repository/sample/mappers/*Mapper.xml"
)
public class TestConfig {

    @Bean
    public DataSource dataSource() throws SQLException {
        return new EmbeddedDatabaseBuilder().setType(EmbeddedDatabaseType.H2).addScript("classpath:/test-init.sql").build();
    }

    @Bean
    public SqlSessionFactoryBean sqlSessionFactory(DataSource dataSource) {
        SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
        factoryBean.setDataSource(dataSource);
        return factoryBean;
    }

    @Bean
    public PlatformTransactionManager transactionManager(DataSource dataSource) {
        return new DataSourceTransactionManager(dataSource);
    }

}

```

创建一个实体类:

```java
@Entity
public class User extends LongId {

  private String firstname;
  private String lastname;
       
  // Getters and setters
  // (Firstname, Lastname)-constructor and noargs-constructor
  // equals / hashcode
}

```

创建一个数据操作接口,使用包名 `com.example.repositories`:

```java
public interface UserRepository extends CrudRepository<User, Long> {
  List<User> findByLastname(String lastname);  
  
}

```

编写一个测试用例:

```java
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = AppConfig.class)
public class UserRepositoryIntegrationTest {
     
  @Autowired UserRepository repository;
     
  @Test
  public void sampleTestCase() {
    User dave = new User("Dave", "Matthews");
    dave = repository.save(dave);
         
    User carter = new User("Carter", "Beauford");
    carter = repository.save(carter);
         
    List<User> result = repository.findByLastname("Matthews");
    assertThat(result.size(), is(1));
    assertThat(result, hasItem(dave));
  }
}

```

这样就完成了。


## 使用 Spring Boot

通过maven引入:
   
   ```xml
   <dependency>
       <groupId>com.ifrabbit</groupId>
       <artifactId>spring-boot-starter-data-mybatis</artifactId>
       <version>1.0.15.RELEASE</version>
   </dependency>
   ```


如果你需要使用自己编写的Mybatis Mapper，需要在application.properties中配置：
```
spring.data.mybatis.mapper-locations=classpath*:/org/springframework/data/mybatis/samples/mappers/*Mapper.xml
```

在Spring Boot中你不需要自己去定义SqlSessionFactory.

完整的代码如下：

```java
@SpringBootApplication
public class SpringDataMybatisSamplesApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringDataMybatisSamplesApplication.class, args);
    }

    @Bean
    public CommandLineRunner dummyCLR(ReservationRepository reservationRepository) {
        return args -> {
            Stream.of("Tom", "Jack", "Apple")
                    .forEach(name -> reservationRepository.save(new Reservation(name)));
        };
    }

}

@RepositoryRestResource // here we use RepositoryRestResource
interface ReservationRepository extends MybatisRepository<Reservation, Long> {
}

@Entity
class Reservation extends LongId {

    private String reservationName;

    public Reservation() {
    }

    public Reservation(String reservationName) {
        this.reservationName = reservationName;
    }

    public String getReservationName() {
        return reservationName;
    }

    @Override
    public String toString() {
        return "Reservation{" +
                "reservationName='" + reservationName + '\'' +
                '}';
    }
}
```

完整的例子可以在  [https://github.com/hatunet/spring-data-mybatis-samples](https://github.com/hatunet/spring-data-mybatis-samples) 找到。


## 贡献代码给 Spring Data MyBatis ##

Here are some ways for you to get involved in the community:

* Github is for social coding: if you want to write code, we encourage contributions through pull requests from [forks of this repository](http://help.github.com/forking/). 

## Help me better - Donation
[![paypal](https://www.paypal.com/en_US/i/btn/x-click-butcc-donate.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=W7PLNCBK5K8JS)

