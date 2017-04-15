# Spring Data MyBatis 
[![Build Status](https://travis-ci.org/hatunet/spring-data-mybatis.svg?branch=master)](https://travis-ci.org/hatunet/spring-data-mybatis)   [![Gitter chat](https://badges.gitter.im/gitterHQ/gitter.png)](https://gitter.im/spring-data-mybatis)
                                                                                                                                                                 



[Simplified Chinese](README_zh.md)

The primary goal of the Spring Data project is to make it easier to build Spring-powered applications that use data access technologies. 
This module deals with enhanced support for MyBatis based data access layers.


## Features ##

* Implementation of CRUD methods for normal Entities
* Dynamic query generation from query method names
* Implementation domain base classes providing basic properties
* Support for transparent auditing (created, last changed)
* Possibility to integrate custom repository code
* Easy Spring integration with custom namespace
* Support MySQL, Oracle, Sql Server, H2, etc.


## Getting Help ##
This README as well as the [reference documentation](https://hatunet.github.io/spring-data-mybatis/) are the best places to start learning about Spring Data MyBatis. 

If you have any question, please record a [issue](https://github.com/hatunet/spring-data-mybatis/issues) to me.


## Quick Start ##

Download the jar through Maven:

```xml
<dependency>
  <groupId>com.ifrabbit</groupId>
  <artifactId>spring-data-mybatis</artifactId>
  <version>1.0.15.RELEASE</version>
</dependency>
```

If you want use snapshot version , you can download the jar through maven:
```xml
<dependency>
  <groupId>com.ifrabbit</groupId>
  <artifactId>spring-data-mybatis</artifactId>
  <version>1.0.16.BUILD-SNAPSHOT</version>
</dependency>
```

but you should add repository configuration to your pom.xml like this:

```xml
<repository>
 <id>oss-snapshots-repo</id>
 <url>https://oss.sonatype.org/content/repositories/snapshots</url>
 <releases><enabled>false</enabled></releases>
 <snapshots><enabled>true</enabled></snapshots>
</repository>
```


The simple Spring Data Mybatis configuration with Java-Config looks like this: 
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

Create an entity:

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

Create a repository interface in `com.example.repositories`:

```java
public interface UserRepository extends CrudRepository<User, Long> {
  List<User> findByLastname(String lastname);  
  
}

```

Write a test client:

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


## Use Spring Boot

add the jar through Maven:
   
   ```xml
   <dependency>
       <groupId>com.ifrabbit</groupId>
       <artifactId>spring-boot-starter-data-mybatis</artifactId>
       <version>1.0.15.RELEASE</version>
   </dependency>
   ```

If you need custom Mapper, you should add property in your application.properties like this:
```
spring.data.mybatis.mapper-locations=classpath*:/org/springframework/data/mybatis/samples/mappers/*Mapper.xml
```

And you need not to define SqlSessionFactory manually.

The full test code like this:

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

The full example you can find in [https://github.com/hatunet/spring-data-mybatis-samples](https://github.com/hatunet/spring-data-mybatis-samples)


## Contributing to Spring Data MyBatis ##

Here are some ways for you to get involved in the community:

* Github is for social coding: if you want to write code, we encourage contributions through pull requests from [forks of this repository](http://help.github.com/forking/). 

## Help me better - Donation
[![paypal](https://www.paypal.com/en_US/i/btn/x-click-butcc-donate.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=W7PLNCBK5K8JS)

