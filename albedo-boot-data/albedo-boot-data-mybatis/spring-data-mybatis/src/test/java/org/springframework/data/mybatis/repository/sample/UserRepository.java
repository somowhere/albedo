/*
 *
 *   Copyright 2016 the original author or authors.
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 *
 */

package org.springframework.data.mybatis.repository.sample;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.domain.Sort;
import org.springframework.data.mybatis.domain.sample.Role;
import org.springframework.data.mybatis.domain.sample.User;
import org.springframework.data.mybatis.repository.annotation.Query;
import org.springframework.data.mybatis.repository.support.MybatisRepository;
import org.springframework.data.repository.query.Param;

import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Set;

/**
 * @author Jarvis Song
 */
public interface UserRepository extends MybatisRepository<User, Integer>, UserRepositoryCustom {

    @Query
    List<User> findUseMapper(@Param("lastname") String lastname);

    @Query("findUseMapper")
    List<User> findUseMapper1(@Param("lastname") String lastname);

    User findByEmailAddressAndLastname(String emailAddress, String lastname);

    User findByEmailAddress(String emailAddress);

    List<User> findByEmailAddressAndLastnameOrFirstname(String emailAddress, String lastname, String username);

    List<User> findByLastname(String lastname);

    Page<User> findByLastname(Pageable pageable, String lastname);

    List<User> findByFirstname(String firstname, Pageable pageable);

    Page<User> findByFirstnameIn(Pageable pageable, String... firstnames);

    List<User> findByFirstnameNotIn(Collection<String> firstnames);

    List<User> findByFirstnameOrLastname(@Param("lastname") String lastname, @Param("firstname") String firstname);

    List<User> findByLastnameLikeOrderByFirstnameDesc(String lastname);

    List<User> findByLastnameNotLike(String lastname);

    List<User> findByLastnameNot(String lastname);

    List<User> findByManagerLastname(String name);

//    List<User> findByColleaguesLastname(String lastname);

    List<User> findByLastnameNotNull();

    List<User> findByLastnameNull();

    List<User> findByEmailAddressLike(String email, Sort sort);

//    List<SpecialUser> findSpecialUsersByLastname(String lastname);

    List<User> findByLastnameIgnoringCase(String lastname);

    Page<User> findByLastnameIgnoringCase(Pageable pageable, String lastname);

    List<User> findByLastnameIgnoringCaseLike(String lastname);

    List<User> findByLastnameAndFirstnameAllIgnoringCase(String lastname, String firstname);

    List<User> findByAgeGreaterThanEqual(int age);

    List<User> findByAgeLessThanEqual(int age);


    List<User> findByActiveTrue();

    List<User> findByActiveFalse();


    List<User> findByCreatedAtBefore(Date date);

    List<User> findByCreatedAtAfter(Date date);

    List<User> findByFirstnameStartingWith(String firstname);

    List<User> findByFirstnameEndingWith(String firstname);

    List<User> findByFirstnameContaining(String firstname);

    long countByLastname(String lastname);

    int countUsersByFirstname(String firstname);

    Collection<User> findByIdIn(@Param("ids") Integer... ids);

    List<User> findAllByOrderByLastnameAsc();

    List<User> findByBinaryData(byte[] data);

    Slice<User> findSliceByLastname(String lastname, Pageable pageable);

//    List<User> findByAttributesIn(Set<String> attributes);

    Long removeByLastname(String lastname);

    List<User> deleteByLastname(String lastname);


    User findFirstByOrderByAgeDesc();

    User findFirst1ByOrderByAgeDesc();

    User findTopByOrderByAgeDesc();

    User findTopByOrderByAgeAsc();

    User findTop1ByOrderByAgeAsc();

    List<User> findTop2ByOrderByAgeDesc();

    List<User> findFirst2ByOrderByAgeDesc();

    List<User> findFirst2UsersBy(Sort sort);

    List<User> findTop2UsersBy(Sort sort);

    Page<User> findFirst3UsersBy(Pageable page);

    Page<User> findFirst2UsersBy(Pageable page);

    Slice<User> findTop3UsersBy(Pageable page);

    Slice<User> findTop2UsersBy(Pageable page);


    List<User> findByAgeIn(Collection<Integer> ages);

    List<User> queryByAgeIn(Integer[] ages);

    List<User> queryByAgeInOrFirstname(Integer[] ages, String firstname);

    List<User> findByLastnameNotContaining(String part);


//    List<User> findByRolesContaining(Role role);
//
//    List<User> findByRolesNotContaining(Role role);
//
//    List<User> findByRolesNameContaining(String name);
//
//    List<RolesAndFirstname> findRolesAndFirstnameBy();

    interface RolesAndFirstname {

        String getFirstname();

        Set<Role> getRoles();
    }
}
