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

package org.springframework.data.mybatis.repository;

import org.hamcrest.Matchers;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.data.mybatis.config.sample.TestConfig;
import org.springframework.data.mybatis.domain.sample.Role;
import org.springframework.data.mybatis.domain.sample.User;
import org.springframework.data.mybatis.repository.sample.RoleRepository;
import org.springframework.data.mybatis.repository.sample.UserRepository;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

import static org.hamcrest.Matchers.*;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThat;
import static org.springframework.data.domain.Sort.Direction.ASC;

/**
 * @author Jarvis Song
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = TestConfig.class)
@Transactional
public class UserRepositoryTests {
    @Autowired
    RoleRepository roleRepository;

    @Autowired
    UserRepository repository;

    // Test fixture
    User firstUser, secondUser, thirdUser, fourthUser;
    Integer id;
    Role    adminRole;

    @Before
    public void setUp() throws Exception {

        firstUser = new User("Oliver", "Gierke", "gierke@synyx.de");
        firstUser.setAge(28);
        secondUser = new User("Joachim", "Arrasz", "arrasz@synyx.de");
        secondUser.setAge(35);
        Thread.sleep(10);
        thirdUser = new User("Dave", "Matthews", "no@email.com");
        thirdUser.setAge(43);
        fourthUser = new User("kevin", "raymond", "no@gmail.com");
        fourthUser.setAge(31);
        adminRole = new Role("admin");

    }

    protected void flushTestUsers() {

        roleRepository.save(adminRole);
        firstUser.setTestData("689797897");
        firstUser = repository.save(firstUser);
        secondUser = repository.save(secondUser);
        thirdUser = repository.save(thirdUser);
        fourthUser = repository.save(fourthUser);


        id = firstUser.getId();

        assertThat(id, is(notNullValue()));
        assertThat(secondUser.getId(), is(notNullValue()));
        assertThat(thirdUser.getId(), is(notNullValue()));
        assertThat(fourthUser.getId(), is(notNullValue()));

        assertThat(repository.exists(id), is(true));
        assertThat(repository.exists(secondUser.getId()), is(true));
        assertThat(repository.exists(thirdUser.getId()), is(true));
        assertThat(repository.exists(fourthUser.getId()), is(true));
    }

    @Test
    public void testFindUseMapper() throws Exception {

        flushTestUsers();

        List<User> byName = repository.findUseMapper("Gierke");

        assertThat(byName.size(), is(1));
        assertThat(byName.get(0), is(firstUser));
    }

    @Test
    public void testFindUseMapperWithStatement() throws Exception {

        flushTestUsers();

        List<User> byName = repository.findUseMapper1("Gierke");

        assertThat(byName.size(), is(1));
        assertThat(byName.get(0), is(firstUser));
    }

    @Test
    public void testRead() throws Exception {

        flushTestUsers();

        User foundPerson = repository.findOne(id);
        assertThat(firstUser.getFirstname(), is(foundPerson.getFirstname()));
    }

    @Test
    public void findsAllByGivenIds() {

        flushTestUsers();

        Iterable<User> result = repository.findAll(Arrays.asList(firstUser.getId(), secondUser.getId()));
        assertThat(result, hasItems(firstUser, secondUser));
    }

    @Test
    public void testReadByIdReturnsNullForNotFoundEntities() {

        flushTestUsers();

        assertThat(repository.findOne(id * 27), is(nullValue()));
    }

    @Test
    public void savesCollectionCorrectly() throws Exception {

        List<User> result = repository.save(Arrays.asList(firstUser, secondUser, thirdUser));
        assertThat(result, is(notNullValue()));
        assertThat(result.size(), is(3));
        assertThat(result, hasItems(firstUser, secondUser, thirdUser));
    }

    @Test
    public void savingNullCollectionIsNoOp() throws Exception {

        List<User> result = repository.save((Collection<User>) null);
        assertThat(result, is(notNullValue()));
        assertThat(result.isEmpty(), is(true));
    }


    @Test
    public void savingEmptyCollectionIsNoOp() throws Exception {

        List<User> result = repository.save(new ArrayList<User>());
        assertThat(result, is(notNullValue()));
        assertThat(result.isEmpty(), is(true));
    }

    @Test
    public void testUpdate() {

        flushTestUsers();

        User foundPerson = repository.findOne(id);
        foundPerson.setLastname("Schlicht");

        User updatedPerson = repository.findOne(id);
        assertThat(updatedPerson.getFirstname(), is(foundPerson.getFirstname()));
    }

    @Test
    public void existReturnsWhetherAnEntityCanBeLoaded() throws Exception {

        flushTestUsers();
        assertThat(repository.exists(id), is(true));
        assertThat(repository.exists(id * 27), is(false));
    }

    @Test
    public void deletesAUserById() {

        flushTestUsers();

        repository.delete(firstUser.getId());
        assertThat(repository.exists(id), is(false));
        assertThat(repository.findOne(id), is(nullValue()));
    }

    @Test
    public void testDelete() {

        flushTestUsers();

        repository.delete(firstUser);
        assertThat(repository.exists(id), is(false));
        assertThat(repository.findOne(id), is(nullValue()));
    }

    @Test
    public void returnsAllSortedCorrectly() throws Exception {

        flushTestUsers();
        List<User> result = repository.findAll(new Sort(ASC, "lastname"));
        assertThat(result, is(notNullValue()));
        assertThat(result.size(), is(4));
        assertThat(result.get(0), is(secondUser));
        assertThat(result.get(1), is(firstUser));
        assertThat(result.get(2), is(thirdUser));
        assertThat(result.get(3), is(fourthUser));
    }

    @Test
    public void returnsAllIgnoreCaseSortedCorrectly() throws Exception {

        flushTestUsers();

        Sort.Order order = new Sort.Order(ASC, "firstname").ignoreCase();
        List<User> result = repository.findAll(new Sort(order));

        assertThat(result, is(notNullValue()));
        assertThat(result.size(), is(4));
        assertThat(result.get(0), is(thirdUser));
        assertThat(result.get(1), is(secondUser));
        assertThat(result.get(2), is(fourthUser));
        assertThat(result.get(3), is(firstUser));
    }

    @Test
    public void deleteColletionOfEntities() {

        flushTestUsers();

        long before = repository.count();

        repository.delete(Arrays.asList(firstUser, secondUser));
        assertThat(repository.exists(firstUser.getId()), is(false));
        assertThat(repository.exists(secondUser.getId()), is(false));
        assertThat(repository.count(), is(before - 2));
    }

    @Test
    public void batchDeleteColletionOfEntities() {

        flushTestUsers();

        long before = repository.count();

        repository.deleteInBatch(Arrays.asList(firstUser, secondUser));
        assertThat(repository.exists(firstUser.getId()), is(false));
        assertThat(repository.exists(secondUser.getId()), is(false));
        assertThat(repository.count(), is(before - 2));
    }

    @Test
    public void deleteEmptyCollectionDoesNotDeleteAnything() {

        assertDeleteCallDoesNotDeleteAnything(new ArrayList<User>());
    }

    @Test
    public void testFinderInvocationWithNullParameter() {

        flushTestUsers();

        repository.findByLastname((String) null);
    }

    @Test
    public void testFindByLastname() throws Exception {

        flushTestUsers();

        List<User> byName = repository.findByLastname("Gierke");

        assertThat(byName.size(), is(1));
        assertThat(byName.get(0), is(firstUser));
    }

    @Test
    public void testFindByEmailAddress() throws Exception {

        flushTestUsers();

        User byName = repository.findByEmailAddress("gierke@synyx.de");

        assertThat(byName, is(notNullValue()));
        assertThat(byName, is(firstUser));
    }

    @Test
    public void testReadAll() {

        flushTestUsers();

        assertThat(repository.count(), is(4L));
        assertThat(repository.findAll(), hasItems(firstUser, secondUser, thirdUser, fourthUser));
    }

    @Test
    public void deleteAll() throws Exception {

        flushTestUsers();

        repository.deleteAll();

        assertThat(repository.count(), is(0L));
    }


    @Test
    public void testCountsCorrectly() {

        long count = repository.count();

        User user = new User();
        user.setEmailAddress("gierke@synyx.de");
        repository.save(user);

        assertThat(repository.count() == count + 1, is(true));
    }

    @Test
    public void executesLikeAndOrderByCorrectly() throws Exception {

        flushTestUsers();

        List<User> result = repository.findByLastnameLikeOrderByFirstnameDesc("%r%");
        assertThat(result.size(), is(3));
        assertEquals(fourthUser, result.get(0));
        assertEquals(firstUser, result.get(1));
        assertEquals(secondUser, result.get(2));
    }

    @Test
    public void executesNotLikeCorrectly() throws Exception {

        flushTestUsers();

        List<User> result = repository.findByLastnameNotLike("%er%");
        assertThat(result.size(), is(3));
        assertThat(result, hasItems(secondUser, thirdUser, fourthUser));
    }

    @Test
    public void executesSimpleNotCorrectly() throws Exception {

        flushTestUsers();

        List<User> result = repository.findByLastnameNot("Gierke");
        assertThat(result.size(), is(3));
        assertThat(result, hasItems(secondUser, thirdUser, fourthUser));
    }


    @Test
    public void returnsSameListIfNoSortIsGiven() throws Exception {

        flushTestUsers();
        assertSameElements(repository.findAll((Sort) null), repository.findAll());
    }

//    @Test
//    public void returnsSamePageIfNoSpecGiven() throws Exception {
//
//        Pageable pageable = new PageRequest(0, 1);
//
//        flushTestUsers();
//        assertThat(repository.findAll(null, pageable), is(repository.findAll(pageable)));
//    }

    @Test
    public void returnsAllAsPageIfNoPageableIsGiven() throws Exception {

        flushTestUsers();
        assertThat(repository.findAll((Pageable) null), is((Page<User>) new PageImpl<User>(repository.findAll())));
    }

    @Test
    public void executesQueryMethodWithDeepTraversalCorrectly() throws Exception {

        flushTestUsers();

        firstUser.setManager(secondUser);
        thirdUser.setManager(firstUser);
        repository.save(Arrays.asList(firstUser, thirdUser));

        List<User> result = repository.findByManagerLastname("Arrasz");

        assertThat(result.size(), is(1));
        assertThat(result, hasItem(firstUser));

        result = repository.findByManagerLastname("Gierke");
        assertThat(result.size(), is(1));
        assertThat(result, hasItem(thirdUser));
    }

//    @Test(expected = MybatisQueryNotSupportException.class)
//    public void executesFindByColleaguesLastnameCorrectly() {
//
//        flushTestUsers();
//
//        firstUser.addColleague(secondUser);
//        thirdUser.addColleague(firstUser);
//        repository.save(Arrays.asList(firstUser, thirdUser));
//
//        List<User> result = repository.findByColleaguesLastname(secondUser.getLastname());
//
//        assertThat(result.size(), is(1));
//        assertThat(result, hasItem(firstUser));
//
//        result = repository.findByColleaguesLastname("Gierke");
//        assertThat(result.size(), is(2));
//        assertThat(result, hasItems(thirdUser, secondUser));
//    }

    @Test
    public void executesFindByNotNullLastnameCorrectly() throws Exception {

        flushTestUsers();
        List<User> result = repository.findByLastnameNotNull();

        assertThat(result.size(), is(4));
        assertThat(result, hasItems(firstUser, secondUser, thirdUser, fourthUser));
    }

    @Test
    public void executesFindByNullLastnameCorrectly() throws Exception {

        flushTestUsers();
        User forthUser = repository.save(new User("Foo", null, "email@address.com"));

        List<User> result = repository.findByLastnameNull();

        assertThat(result.size(), is(1));
        assertThat(result, hasItems(forthUser));
    }

    @Test
    public void findsSortedByLastname() throws Exception {

        flushTestUsers();

        List<User> result = repository.findByEmailAddressLike("%@%", new Sort(Sort.Direction.ASC, "lastname"));

        assertThat(result.size(), is(4));
        assertThat(result.get(0), is(secondUser));
        assertThat(result.get(1), is(firstUser));
        assertThat(result.get(2), is(thirdUser));
        assertThat(result.get(3), is(fourthUser));
    }

    @Test
    public void executesLessThatOrEqualQueriesCorrectly() {

        flushTestUsers();

        List<User> result = repository.findByAgeLessThanEqual(35);
        assertThat(result.size(), is(3));
        assertThat(result, hasItems(firstUser, secondUser, fourthUser));
    }

    @Test
    public void executesGreaterThatOrEqualQueriesCorrectly() {

        flushTestUsers();

        List<User> result = repository.findByAgeGreaterThanEqual(35);
        assertThat(result.size(), is(2));
        assertThat(result, hasItems(secondUser, thirdUser));
    }

    @Test
    public void executesFinderWithTrueKeywordCorrectly() {

        flushTestUsers();
        firstUser.setActive(false);
        repository.save(firstUser);

        List<User> result = repository.findByActiveTrue();
        assertThat(result.size(), is(3));
        assertThat(result, hasItems(secondUser, thirdUser, fourthUser));
    }

    @Test
    public void executesFinderWithFalseKeywordCorrectly() {

        flushTestUsers();
        firstUser.setActive(false);
        repository.save(firstUser);

        List<User> result = repository.findByActiveFalse();
        assertThat(result.size(), is(1));
        assertThat(result, hasItem(firstUser));
    }

    @Test
    public void executesFinderWithAfterKeywordCorrectly() {

        flushTestUsers();

        List<User> result = repository.findByCreatedAtAfter(secondUser.getCreatedAt());
        assertThat(result.size(), is(2));
        assertThat(result, hasItems(thirdUser, fourthUser));
    }

    @Test
    public void executesFinderWithBeforeKeywordCorrectly() {

        flushTestUsers();

        List<User> result = repository.findByCreatedAtBefore(thirdUser.getCreatedAt());
        assertThat(result.size(), is(2));
        assertThat(result, hasItems(firstUser, secondUser));
    }

    @Test
    public void executesFinderWithStartingWithCorrectly() {

        flushTestUsers();
        List<User> result = repository.findByFirstnameStartingWith("Oli");
        assertThat(result.size(), is(1));
        assertThat(result, hasItem(firstUser));
    }

    @Test
    public void executesFinderWithEndingWithCorrectly() {

        flushTestUsers();
        List<User> result = repository.findByFirstnameEndingWith("er");
        assertThat(result.size(), is(1));
        assertThat(result, hasItem(firstUser));
    }

    @Test
    public void executesFinderWithContainingCorrectly() {

        flushTestUsers();
        List<User> result = repository.findByFirstnameContaining("a");
        assertThat(result.size(), is(2));
        assertThat(result, hasItems(secondUser, thirdUser));
    }

    @Test
    public void allowsExecutingPageableMethodWithNullPageable() {

        flushTestUsers();

        List<User> users = repository.findByFirstname("Oliver", null);
        assertThat(users.size(), is(1));
        assertThat(users, hasItem(firstUser));

        Page<User> page = repository.findByFirstnameIn(null, "Oliver");
        assertThat(page.getNumberOfElements(), is(1));
        assertThat(page.getContent(), hasItem(firstUser));

        page = repository.findAll((Pageable) null);
        assertThat(page.getNumberOfElements(), is(4));
        assertThat(page.getContent(), hasItems(firstUser, secondUser, thirdUser, fourthUser));
    }

    @Test
    public void handlesIterableOfIdsCorrectly() {

        flushTestUsers();

        Set<Integer> set = new HashSet<Integer>();
        set.add(firstUser.getId());
        set.add(secondUser.getId());

        Iterable<User> result = repository.findAll(set);

        assertThat(result, is(Matchers.<User>iterableWithSize(2)));
        assertThat(result, hasItems(firstUser, secondUser));
    }

    @Test
    public void ordersByReferencedEntityCorrectly() {

        flushTestUsers();
        firstUser.setManager(thirdUser);
        repository.save(firstUser);

        Page<User> all = repository.findAll(new PageRequest(0, 10, new Sort("manager.id")));

        assertThat(all.getContent().isEmpty(), is(false));
    }


    private void assertDeleteCallDoesNotDeleteAnything(List<User> collection) {

        flushTestUsers();
        long count = repository.count();

        repository.delete(collection);
        assertThat(repository.count(), is(count));
    }

    private static <T> void assertSameElements(Collection<T> first, Collection<T> second) {

        for (T element : first) {
            assertThat(element, isIn(second));
        }

        for (T element : second) {
            assertThat(element, isIn(first));
        }
    }

    @Test
    public void testFindByFirstnameOrLastname() throws Exception {
        flushTestUsers();
        List<User> byFirstnameOrLastname = repository.findByFirstnameOrLastname(firstUser.getFirstname(),fourthUser.getLastname());
        assertThat(byFirstnameOrLastname.size(),is(2));
        assertThat(byFirstnameOrLastname.get(0), is(firstUser));
        assertThat(byFirstnameOrLastname.get(1), is(fourthUser));
    }

}
