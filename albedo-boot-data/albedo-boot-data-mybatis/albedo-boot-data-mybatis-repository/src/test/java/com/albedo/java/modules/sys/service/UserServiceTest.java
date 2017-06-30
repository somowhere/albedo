package com.albedo.java.modules.sys.service;

import com.albedo.java.config.TestConfig;
import com.albedo.java.modules.sys.domain.Module;
import com.albedo.java.modules.sys.domain.Org;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.repository.ModuleRepository;
import com.albedo.java.modules.sys.repository.UserRepository;
import com.albedo.java.util.domain.PageModel;
import com.google.common.collect.Sets;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

import static org.hamcrest.Matchers.*;
import static org.junit.Assert.assertThat;
import static org.springframework.data.domain.Sort.Direction.ASC;

/**
 * Created by lijie on 2017/4/19.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = TestConfig.class)
@Transactional
public class UserServiceTest {

    @Autowired
    UserRepository repository;
    @Autowired
    ModuleRepository moduleRepository;

    @Autowired
    UserService userService;
    @Autowired
    RoleService roleService;

    @Autowired
    OrgService orgService;

    // Test fixture
    User user1, user2, user3, user4;
    String id;
    Set<Role> roles = Sets.newHashSet();

    Role role1, role2;

    Org org, orgParent;

    @Before
    public void setUp() throws Exception {
        orgParent = new Org();
        orgParent.setName("nameParent1");
        orgParent.setCode("codeParent1");
        
        org = new Org();
        org.setName("name1");
        org.setCode("code1");
        org.setDescription("org");
        

        role1 = new Role();
        role1.setName("role1");
        role1.setOrgId(org.getId());
        role2 = new Role();
        role2.setName("role2");
        role2.setOrgId(org.getId());
        roles.add(role1);
        roles.add(role2);
        

        user1 = new User();
        user1.setLoginId("admin1");
        user1.setPassword("111111");
        user1.setEmail("email1");
        

        user2 = new User();
        user2.setLoginId("admin2");
        user2.setPassword("222222");
        
        user2.setEmail("email2");
        

        user3 = new User();
        user3.setLoginId("admin33");
        user3.setPassword("3333333");
        
        
        user3.setEmail("email3");
        

        user4 = new User();
        user4.setLoginId("admin44");
        user4.setPassword("4444444");
        
        user4.setEmail("email4");
        

    }

    private void flushTestUsers() {
        orgParent=orgService.save(orgParent);
        org.setParentId(orgParent.getId());
        org = orgService.save(org);
        roles = (Set<Role>) roleService.save(roles);

        user1.setOrgId(org.getId());
        user1.setRoles(roles);
        user1 = userService.save(user1);

        user2.setOrgId(org.getId());
        user2.setRoles(roles);
        userService.save(user2);
        
        
        user3.setOrgId(org.getId());
        user3.setRoles(roles);
        userService.save(user3);


        user4.setOrgId(org.getId());
        user4.setRoles(roles);
        userService.save(user4);
        

        id = user1.getId();

        assertThat(id, is(notNullValue()));
        assertThat(user2.getId(), is(notNullValue()));
        assertThat(user3.getId(), is(notNullValue()));
        assertThat(user4.getId(), is(notNullValue()));

        assertThat(repository.exists(id), is(true));
        assertThat(repository.exists(user2.getId()), is(true));
        assertThat(repository.exists(user3.getId()), is(true));
        assertThat(repository.exists(user4.getId()), is(true));
        
    }
    
    

    @Test
    public void findPage() throws Exception {

        flushTestUsers();
        
        PageModel<User> pm = new PageModel<User>(1, 10);
        pm.setSort(new Sort(new Sort.Order(Sort.Direction.ASC, "loginId")));
        userService.findPage(pm);
        
        assertThat(pm.getData().size(), is(4));
        assertThat(pm.getData().get(0).getLoginId(), is(user1.getLoginId()));

        User temp = repository.findOneByLoginId(user1.getLoginId()).get();

        List<Module> modules = moduleRepository.findAllAuthByUser(new User("1"));
//        assertThat(modules.size()!=0, is(true));
        assertThat(pm.getData().get(0), is(temp));


    }

    @Test
    public void testRead() throws Exception {

        flushTestUsers();
        
        User foundPerson = repository.findOne(id);
        assertThat(user1.getName(), is(foundPerson.getName()));
    }

//    @Test
//    public void findsAllByGivenIds() {
//
//        flushTestUsers();
//
//        Iterable<User> result = repository.findAll(Arrays.asList(user1.getId(), user2.getId()));
//        assertThat(result, hasItems(user1, user2));
//    }

    

    @Test
    public void testReadByIdReturnsNullForNotFoundEntities() {

        flushTestUsers();

        assertThat(repository.findOne(id + 27), is(nullValue()));
    }

    @Test
    public void savesCollectionCorrectly() throws Exception {

        List<User> result = repository.save(Arrays.asList(user1, user2, user3));
        assertThat(result, is(notNullValue()));
        assertThat(result.size(), is(3));
        assertThat(result, hasItems(user1, user2, user3));
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
        foundPerson.setName("Schlicht");

        User updatedPerson = repository.findOne(id);
        assertThat(updatedPerson.getName(), is(foundPerson.getName()));
    }

    @Test
    public void existReturnsWhetherAnEntityCanBeLoaded() throws Exception {

        flushTestUsers();
        assertThat(repository.exists(id), is(true));
        assertThat(repository.exists(id + 27), is(false));
    }

    @Test
    public void deletesAUserById() {

        flushTestUsers();

        repository.delete(user1.getId());
        assertThat(repository.exists(id), is(false));
        assertThat(repository.findOne(id), is(nullValue()));
    }

    @Test
    public void testDelete() {

        flushTestUsers();

        repository.delete(user1);
        assertThat(repository.exists(id), is(false));
        assertThat(repository.findOne(id), is(nullValue()));
    }

    @Test
    public void returnsAllSortedCorrectly() throws Exception {

        flushTestUsers();
        List<User> result = repository.findAll(new Sort(ASC, "loginId"));
        assertThat(result, is(notNullValue()));
        assertThat(result.size(), is(4));
        assertThat(result.get(0).getLoginId(), is(user1.getLoginId()));
        assertThat(result.get(1).getLoginId(), is(user2.getLoginId()));
        assertThat(result.get(2).getLoginId(), is(user3.getLoginId()));
        assertThat(result.get(3).getLoginId(), is(user4.getLoginId()));
    }

    @Test
    public void returnsAllIgnoreCaseSortedCorrectly() throws Exception {

        flushTestUsers();

        Sort.Order order = new Sort.Order(ASC, "loginId").ignoreCase();
        List<User> result = repository.findAll(new Sort(order));

        assertThat(result, is(notNullValue()));
        assertThat(result.size(), is(4));
        assertThat(result.get(0).getLoginId(), is(user1.getLoginId()));
        assertThat(result.get(1).getLoginId(), is(user2.getLoginId()));
        assertThat(result.get(2).getLoginId(), is(user3.getLoginId()));
        assertThat(result.get(3).getLoginId(), is(user4.getLoginId()));
    }

    @Test
    public void deleteColletionOfEntities() {

        flushTestUsers();

        long before = repository.count();

        repository.delete(Arrays.asList(user1, user2));
        assertThat(repository.exists(user1.getId()), is(false));
        assertThat(repository.exists(user2.getId()), is(false));
        assertThat(repository.count(), is(before - 2));
    }
    

    @Test
    public void deleteEmptyCollectionDoesNotDeleteAnything() {

        assertDeleteCallDoesNotDeleteAnything(new ArrayList<User>());
    }





    @Test
    public void testReadAll() {

        flushTestUsers();

        assertThat(repository.count(), is(4L));
//        assertThat(repository.findAll(), hasItems(user1, user2, user3, user4));
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
        user.setLoginId("tempLoginId");
        user.setEmail("gierke@synyx.de");
        repository.save(user);

        assertThat(repository.count() == count + 1, is(true));
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


//    @Test(expected = MybatisQueryNotSupportException.class)
//    public void executesFindByColleaguesLastnameCorrectly() {
//
//        flushTestUsers();
//
//        user1.addColleague(user2);
//        user3.addColleague(user1);
//        repository.save(Arrays.asList(user1, user3));
//
//        List<User> result = repository.findByColleaguesLastname(user2.getLastname());
//
//        assertThat(result.size(), is(1));
//        assertThat(result, hasItem(user1));
//
//        result = repository.findByColleaguesLastname("Gierke");
//        assertThat(result.size(), is(2));
//        assertThat(result, hasItems(user3, user2));
//    }



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

    

}