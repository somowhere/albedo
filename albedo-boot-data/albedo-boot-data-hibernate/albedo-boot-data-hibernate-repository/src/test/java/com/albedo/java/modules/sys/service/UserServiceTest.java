package com.albedo.java.modules.sys.service;

import com.albedo.java.common.data.persistence.DynamicSpecifications;
import com.albedo.java.config.TestConfig;
import com.albedo.java.modules.sys.domain.Module;
import com.albedo.java.modules.sys.domain.Org;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.repository.ModuleRepository;
import com.albedo.java.modules.sys.repository.OrgRepository;
import com.albedo.java.modules.sys.repository.RoleRepository;
import com.albedo.java.modules.sys.repository.UserRepository;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import com.google.common.collect.Sets;
import org.hibernate.Session;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import java.util.*;

import static org.hamcrest.Matchers.*;
import static org.junit.Assert.assertThat;
import static org.springframework.data.domain.Sort.Direction.ASC;

/**
 * Created by lijie on 2017/4/19.
 */
@RunWith(SpringRunner.class)
@DataJpaTest
@ContextConfiguration(classes = TestConfig.class)
@Transactional
public class UserServiceTest {

    @Autowired
    UserRepository userRepository;
    @Autowired
    ModuleRepository moduleRepository;

    @Autowired
    OrgRepository orgRepository;
    @Autowired
    RoleRepository roleRepository;
    @Autowired
    UserService userService;
    @Autowired
    RoleService roleService;

    @Autowired
    OrgService orgService;
    @Autowired
    ModuleService moduleService;
    // Test fixture
    User user1, user2, user3, user4;
    String id;
    Set<Role> roles = Sets.newHashSet();
    Role role1, role2;
    Org org, orgParent;
    @PersistenceContext
    private EntityManager em;

    private static <T> void assertSameElements(Collection<T> first, Collection<T> second) {

        for (T element : first) {
            assertThat(element, isIn(second));
        }

        for (T element : second) {
            assertThat(element, isIn(first));
        }
    }

    /*
     * (non-Javadoc)
     *
     * @see com.albedo.java.userRepository.data.support.Itest#getSession()
     */
    public Session getSession() {
        return (Session) em.getDelegate();
    }

    /*
     * (non-Javadoc)
     *
     * @see com.albedo.java.userRepository.data.support.Itest#flush()
     */
    public void flush() {
        getSession().flush();
    }

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

    public void flushTestUsers() {
        if(!getSession().isJoinedToTransaction()){
            getSession().beginTransaction();
        }
        User userAdmin = new User();
        userAdmin.setId("1");
        userAdmin.setLoginId("admin");
        userRepository.findOneByLoginId(userAdmin.getLoginId()).ifPresent(t -> {
            userAdmin.setId(t.getId());
        });
        userRepository.save(userAdmin);
        getSession().flush();
        orgRepository.findOneByName(orgParent.getName()).ifPresent(t -> {
            orgParent.setId(t.getId());
        });
        orgParent = orgService.save(orgParent);
        org.setParentId(orgParent.getId());
        orgRepository.findOneByName(org.getName()).ifPresent(t -> {
            org.setId(t.getId());
        });
        org = orgService.save(org);
        roles = (Set<Role>) roleService.save(roles);

        user1.setOrgId(org.getId());
        user1.setRoles(roles);
        userRepository.findOneByLoginId(user1.getLoginId()).ifPresent(t -> {
            user1.setId(t.getId());
        });
        user1 = userService.save(user1);

        user2.setOrgId(org.getId());
        user2.setRoles(roles);
        userRepository.findOneByLoginId(user2.getLoginId()).ifPresent(t -> {
            user2.setId(t.getId());
        });
        userService.save(user2);


        user3.setOrgId(org.getId());
        user3.setRoles(roles);
        userRepository.findOneByLoginId(user3.getLoginId()).ifPresent(t -> {
            user3.setId(t.getId());
        });
        userService.save(user3);


        user4.setOrgId(org.getId());
        user4.setRoles(roles);
        userRepository.findOneByLoginId(user4.getLoginId()).ifPresent(t -> {
            user4.setId(t.getId());
        });
        userService.save(user4);

        id = user1.getId();

        assertThat(id, is(notNullValue()));
        assertThat(user2.getId(), is(notNullValue()));
        assertThat(user3.getId(), is(notNullValue()));
        assertThat(user4.getId(), is(notNullValue()));
        getSession().flush();
        assertThat(userRepository.exists(id), is(true));
        assertThat(userRepository.exists(user2.getId()), is(true));
        assertThat(userRepository.exists(user3.getId()), is(true));
        assertThat(userRepository.exists(user4.getId()), is(true));
        getSession().getTransaction().commit();
    }


    @Test
    public void findPage() throws Exception {

        flushTestUsers();

        PageModel<User> pm = new PageModel<User>(1, 10);
        pm.setSort(new Sort(new Sort.Order(Sort.Direction.ASC, "loginId")));
        userService.findPage(pm);

        assertThat(pm.getData().size(), is(5));
        assertThat(pm.getData().get(1).getLoginId(), is(user1.getLoginId()));

        User temp = userRepository.findOneByLoginId(user1.getLoginId()).get();

        List<Module> modules = moduleService.findAllAuthByUser("1");
//        assertThat(modules.size()!=0, is(true));
        assertThat(pm.getData().get(1), is(temp));


    }

//    @Test
//    public void findsAllByGivenIds() {
//
//        flushTestUsers();
//
//        Iterable<User> result = userRepository.findAll(Arrays.asList(user1.getId(), user2.getId()));
//        assertThat(result, hasItems(user1, user2));
//    }

    @Test
    public void testRead() throws Exception {

        flushTestUsers();

        User foundPerson = userRepository.findOne(id);
        assertThat(user1.getName(), is(foundPerson.getName()));
    }

    @Test
    public void testReadByIdReturnsNullForNotFoundEntities() {

        flushTestUsers();

        assertThat(userRepository.findOne(id + 27), is(nullValue()));
    }

    @Test
    public void savesCollectionCorrectly() throws Exception {

        List<User> result = userRepository.save(Arrays.asList(user1, user2, user3));
        assertThat(result, is(notNullValue()));
        assertThat(result.size(), is(3));
        assertThat(result, hasItems(user1, user2, user3));
    }

    @Test
    public void savingNullCollectionIsNoOp() throws Exception {

        List<User> result = userRepository.save((Collection<User>) null);
        assertThat(result, is(notNullValue()));
        assertThat(result.isEmpty(), is(true));
    }

    @Test
    public void savingEmptyCollectionIsNoOp() throws Exception {

        List<User> result = userRepository.save(new ArrayList<User>());
        assertThat(result, is(notNullValue()));
        assertThat(result.isEmpty(), is(true));
    }

    @Test
    public void testUpdate() {

        flushTestUsers();

        User foundPerson = userRepository.findOne(id);
        foundPerson.setName("Schlicht");
        userRepository.save(foundPerson);
        User updatedPerson = userRepository.findOne(id);
        assertThat(updatedPerson.getName(), is(foundPerson.getName()));
    }

    @Test
    public void existReturnsWhetherAnEntityCanBeLoaded() throws Exception {

        flushTestUsers();
        assertThat(userRepository.exists(id), is(true));
        assertThat(userRepository.exists(id + 27), is(false));
    }

    @Test
    public void deletesAUserById() {

        flushTestUsers();
        if(!getSession().isJoinedToTransaction()){
            getSession().beginTransaction();
        }
        userRepository.delete(user1.getId());
        getSession().flush();
        assertThat(userRepository.exists(id), is(false));
        assertThat(userRepository.findOne(id), is(nullValue()));

        getSession().getTransaction().commit();
    }

    @Test
    public void testDelete() {

        flushTestUsers();
        if(!getSession().isJoinedToTransaction()){
            getSession().beginTransaction();
        }
        userRepository.delete(user1);
        getSession().flush();
        assertThat(userRepository.exists(id), is(false));
        assertThat(userRepository.findOne(id), is(nullValue()));

        getSession().getTransaction().commit();
    }

    @Test
    public void returnsAllSortedCorrectly() throws Exception {

        flushTestUsers();
        List<User> result = userRepository.findAll(new Sort(ASC, "loginId"));
        assertThat(result, is(notNullValue()));
        assertThat(result.size(), is(5));
        assertThat(result.get(1).getLoginId(), is(user1.getLoginId()));
        assertThat(result.get(2).getLoginId(), is(user2.getLoginId()));
        assertThat(result.get(3).getLoginId(), is(user3.getLoginId()));
        assertThat(result.get(4).getLoginId(), is(user4.getLoginId()));
    }

    @Test
    public void returnsAllIgnoreCaseSortedCorrectly() throws Exception {

        flushTestUsers();

        Sort.Order order = new Sort.Order(ASC, "loginId").ignoreCase();
        List<User> result = userRepository.findAll(new Sort(order));

        assertThat(result, is(notNullValue()));
        assertThat(result.size(), is(6));
        assertThat(result.get(1).getLoginId(), is(user1.getLoginId()));
        assertThat(result.get(2).getLoginId(), is(user2.getLoginId()));
        assertThat(result.get(3).getLoginId(), is(user3.getLoginId()));
        assertThat(result.get(4).getLoginId(), is(user4.getLoginId()));
    }

    @Test
    public void deleteColletionOfEntities() {

        flushTestUsers();
        if(!getSession().isJoinedToTransaction()){
            getSession().beginTransaction();
        }
        long before = userRepository.count();

        userRepository.delete(Arrays.asList(user1, user2));
        getSession().flush();
        assertThat(userRepository.exists(user1.getId()), is(false));
        assertThat(userRepository.exists(user2.getId()), is(false));
        assertThat(userRepository.count(), is(before - 2));

        getSession().getTransaction().commit();
    }

    @Test
    public void deleteEmptyCollectionDoesNotDeleteAnything() {

        assertDeleteCallDoesNotDeleteAnything(new ArrayList<User>());
    }

    @Test
    public void testReadAll() {

        flushTestUsers();

        assertThat(userRepository.count(), is(5L));
//        assertThat(userRepository.findAll(), hasItems(user1, user2, user3, user4));
    }

    @Test
    public void deleteAll() throws Exception {

        flushTestUsers();
        if(!getSession().isJoinedToTransaction()){
            getSession().beginTransaction();
        }
        userRepository.delete(userRepository.findAll(
                DynamicSpecifications.bySearchQueryCondition(
                        QueryCondition.ne(User.F_ID, "1"))
        ));

        getSession().flush();
        assertThat(userRepository.count(), is(1L));

        getSession().getTransaction().commit();
    }

    @Test
    public void testCountsCorrectly() {
        flushTestUsers();
        if(!getSession().isJoinedToTransaction()){
            getSession().beginTransaction();
        }
        long count = userRepository.count();

        User user = new User();
        user.setLoginId("tempLoginId");
        user.setEmail("gierke@synyx.de");
        userRepository.save(user);

        getSession().flush();
        assertThat(userRepository.count() == count + 1, is(true));

        getSession().getTransaction().commit();
    }

//    @Test
//    public void returnsSamePageIfNoSpecGiven() throws Exception {
//
//        Pageable pageable = new PageRequest(0, 1);
//
//        flushTestUsers();
//        assertThat(userRepository.findAll(null, pageable), is(userRepository.findAll(pageable)));
//    }

    @Test
    public void returnsSameListIfNoSortIsGiven() throws Exception {

        flushTestUsers();
        assertSameElements(userRepository.findAll((Sort) null), userRepository.findAll());
    }


//    @Test(expected = MybatisQueryNotSupportException.class)
//    public void executesFindByColleaguesLastnameCorrectly() {
//
//        flushTestUsers();
//
//        user1.addColleague(user2);
//        user3.addColleague(user1);
//        userRepository.save(Arrays.asList(user1, user3));
//
//        List<User> result = userRepository.findByColleaguesLastname(user2.getLastname());
//
//        assertThat(result.size(), is(1));
//        assertThat(result, hasItem(user1));
//
//        result = userRepository.findByColleaguesLastname("Gierke");
//        assertThat(result.size(), is(2));
//        assertThat(result, hasItems(user3, user2));
//    }

    @Test
    public void returnsAllAsPageIfNoPageableIsGiven() throws Exception {

        flushTestUsers();
        assertThat(userRepository.findAll((Pageable) null), is((Page<User>) new PageImpl<User>(userRepository.findAll())));
    }

    private void assertDeleteCallDoesNotDeleteAnything(List<User> collection) {

        flushTestUsers();
        if(!getSession().isJoinedToTransaction()){
            getSession().beginTransaction();
        }
        long count = userRepository.count();

        userRepository.delete(collection);
        getSession().flush();
        assertThat(userRepository.count(), is(count));
        getSession().getTransaction().commit();
    }


}