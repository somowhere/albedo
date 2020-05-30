package com.albedo.java.modules.sys.web;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.handler.GlobalExceptionHandler;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.modules.AlbedoAdminApplication;
import com.albedo.java.modules.TestUtil;
import com.albedo.java.modules.sys.domain.Menu;
import com.albedo.java.modules.sys.domain.dto.MenuDto;
import com.albedo.java.modules.sys.service.MenuService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static com.albedo.java.modules.TestUtil.createFormattingConversionService;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Test class for the MenuResource REST web.
 *
 * @see MenuResource
 */
@SpringBootTest(classes = AlbedoAdminApplication.class)
@Slf4j
public class MenuResourceIntTest {


	private static final String DEFAULT_ANOTHER_NAME = "ANOTHER_NAME";
	private static final String DEFAULT_NAME = "NAME1";
	private static final String UPDATED_NAME = "NAME2";
	private static final String DEFAULT_ANOTHER_PERMISSION = "ANOTHER_PERMISSION";
	private static final String DEFAULT_PERMISSION = "PERMISSION1";
	private static final String UPDATED_PERMISSION = "PERMISSION2";
	private static final Integer DEFAULT_HIDDEN = CommonConstants.NO;
	private static final Integer UPDATED_HIDDEN = CommonConstants.YES;
	private static final Integer DEFAULT_CACHE = CommonConstants.YES;
	private static final Integer UPDATED_CACHE = CommonConstants.NO;
	private static final Integer DEFAULT_IFRAME = CommonConstants.YES;
	private static final Integer UPDATED_IFRAME = CommonConstants.NO;
	private static final String DEFAULT_ANOTHER_ICON = "ANOTHER_ICON";
	private static final String DEFAULT_ICON = "ICON1";
	private static final String UPDATED_ICON = "ICON2";
	private static final String DEFAULT_ANOTHER_PARENTID = "ANOTHER_PARENTID";
	//    private static final String DEFAULT_PARENTID = "PARENTID1";
	private static final String UPDATED_PARENTID = "PARENTID2";
	private static final Integer DEFAULT_SORT = 10;
	private static final Integer UPDATED_SORT = 20;
	private static final String DEFAULT_COMPONENT = "COMPONENT1";
	private static final String UPDATED_COMPONENT = "COMPONENT2";
	private static final String DEFAULT_TYPE = CommonConstants.STR_YES;
	private static final String UPDATED_TYPE = CommonConstants.STR_NO;
	private static final String DEFAULT_PATH = "PATH1";
	private static final String UPDATED_PATH = "PATH2";
	private static final String DEFAULT_DESCRIPTION = "DESCRIPTION1";
	private static final String UPDATED_DESCRIPTION = "DESCRIPTION2";
	private String DEFAULT_API_URL;
	@Autowired
	private MenuService menuService;

	private MockMvc restMenuMockMvc;
	@Autowired
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;
	@Autowired
	private GlobalExceptionHandler globalExceptionHandler;
	@Autowired
	private ApplicationProperties applicationProperties;

	private MenuDto menu;

	private MenuDto anotherMenu = new MenuDto();

	@BeforeEach
	public void setup() {
		DEFAULT_API_URL = applicationProperties.getAdminPath("/sys/menu/");
		MockitoAnnotations.initMocks(this);
		final MenuResource menuResource = new MenuResource(menuService);
		this.restMenuMockMvc = MockMvcBuilders.standaloneSetup(menuResource)
			.addPlaceholderValue(TestUtil.ADMIN_PATH, applicationProperties.getAdminPath())
			.setControllerAdvice(globalExceptionHandler)
			.setConversionService(createFormattingConversionService())
			.setMessageConverters(jacksonMessageConverter)
			.build();
	}

	/**
	 * Create a Menu.
	 * <p>
	 * This is a static method, as tests for other entities might also need it,
	 * if they test an domain which has a required relationship to the Menu domain.
	 */
	public MenuDto createEntity() {
		MenuDto menu = new MenuDto();
		menu.setName(DEFAULT_NAME);
		menu.setComponent(DEFAULT_COMPONENT);
		menu.setIcon(DEFAULT_ICON);
		menu.setPermission(DEFAULT_PERMISSION);
		menu.setHidden(DEFAULT_HIDDEN);
		menu.setCache(DEFAULT_CACHE);
		menu.setIframe(DEFAULT_IFRAME);
		menu.setSort(DEFAULT_SORT);
		menu.setComponent(DEFAULT_COMPONENT);
		menu.setPath(DEFAULT_PATH);
		menu.setType(DEFAULT_TYPE);
		menu.setDescription(DEFAULT_DESCRIPTION);
		return menu;
	}

	@BeforeEach
	public void initTest() {
		menu = createEntity();
		// Initialize the database

		anotherMenu.setName(DEFAULT_ANOTHER_NAME);
		anotherMenu.setIcon(DEFAULT_ANOTHER_ICON);
		anotherMenu.setParentId(DEFAULT_ANOTHER_PARENTID);
		anotherMenu.setPermission(DEFAULT_ANOTHER_PERMISSION);
		anotherMenu.setHidden(DEFAULT_HIDDEN);
		anotherMenu.setCache(DEFAULT_CACHE);
		anotherMenu.setIframe(DEFAULT_IFRAME);
		anotherMenu.setSort(DEFAULT_SORT);
		anotherMenu.setComponent(DEFAULT_COMPONENT);
		anotherMenu.setPath(DEFAULT_PATH);
		anotherMenu.setType(DEFAULT_TYPE);
		anotherMenu.setDescription(DEFAULT_DESCRIPTION);
		menuService.saveOrUpdate(anotherMenu);

		menu.setParentId(anotherMenu.getId());
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void createMenu() throws Exception {
		List<Menu> databaseSizeBeforeCreate = menuService.list();

		// Create the Menu
		restMenuMockMvc.perform(post(DEFAULT_API_URL)
			.contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(menu)))
			.andExpect(status().isOk());

		// Validate the Menu in the database
		List<Menu> menuList = menuService.list();
		assertThat(menuList).hasSize(databaseSizeBeforeCreate.size() + 1);
		Menu testMenu = menuService.getOne(Wrappers.<Menu>query().lambda()
			.eq(Menu::getName, menu.getName()));
		assertThat(testMenu.getName()).isEqualTo(DEFAULT_NAME);
		assertThat(testMenu.getPermission()).isEqualTo(DEFAULT_PERMISSION);
		assertThat(testMenu.getIcon()).isEqualTo(DEFAULT_ICON);
		assertThat(testMenu.getSort()).isEqualTo(DEFAULT_SORT);
		assertThat(testMenu.getParentId()).isEqualTo(anotherMenu.getId());
		assertThat(testMenu.getParentIds()).contains(anotherMenu.getId());
		assertThat(testMenu.getComponent()).isEqualTo(DEFAULT_COMPONENT);
		assertThat(testMenu.getHidden()).isEqualTo(DEFAULT_HIDDEN);
		assertThat(testMenu.getCache()).isEqualTo(DEFAULT_CACHE);
		assertThat(testMenu.getIframe()).isEqualTo(DEFAULT_IFRAME);
		assertThat(testMenu.getType()).isEqualTo(DEFAULT_TYPE);
		assertThat(testMenu.getPath()).isEqualTo(DEFAULT_PATH);
		assertThat(testMenu.isLeaf()).isEqualTo(true);
		assertThat(testMenu.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
		assertThat(testMenu.getDelFlag()).isEqualTo(Menu.FLAG_NORMAL);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void createMenuWithExistingCode() throws Exception {
		// Initialize the database
		menuService.saveOrUpdate(menu);
		int databaseSizeBeforeCreate = menuService.list().size();

		// Create the Menu
		MenuDto managedMenuVM = createEntity();

		// Create the Menu
		restMenuMockMvc.perform(post(DEFAULT_API_URL)
			.contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(managedMenuVM)))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.code").value(CommonConstants.FAIL))
			.andExpect(jsonPath("$.message").isNotEmpty());

		// Validate the Menu in the database
		List<Menu> menuList = menuService.list();
		assertThat(menuList).hasSize(databaseSizeBeforeCreate);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getMenuPage() throws Exception {
		// Initialize the database
		menuService.saveOrUpdate(menu);
		// Get all the menus
		restMenuMockMvc.perform(get(DEFAULT_API_URL)
			.param(PageModel.F_DESC, "menu." + Menu.F_SQL_CREATEDDATE)
			.accept(MediaType.APPLICATION_JSON))
			.andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.records.[*].name").value(hasItem(DEFAULT_NAME)))
			.andExpect(jsonPath("$.data.records.[*].permission").value(hasItem(DEFAULT_PERMISSION)))
			.andExpect(jsonPath("$.data.records.[*].icon").value(hasItem(DEFAULT_ICON)))
			.andExpect(jsonPath("$.data.records.[*].hidden").value(hasItem(DEFAULT_HIDDEN)))
			.andExpect(jsonPath("$.data.records.[*].cache").value(hasItem(DEFAULT_CACHE)))
			.andExpect(jsonPath("$.data.records.[*].iframe").value(hasItem(DEFAULT_IFRAME)))
			.andExpect(jsonPath("$.data.records.[*].sort").value(hasItem(DEFAULT_SORT)))
			.andExpect(jsonPath("$.data.records.[*].parentId").value(hasItem(anotherMenu.getId())))
			.andExpect(jsonPath("$.data.records.[*].component").value(hasItem(DEFAULT_COMPONENT)))
			.andExpect(jsonPath("$.data.records.[*].type").value(hasItem(DEFAULT_TYPE)))
			.andExpect(jsonPath("$.data.records.[*].path").value(hasItem(DEFAULT_PATH)))
			.andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
		;
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getMenu() throws Exception {
		// Initialize the database
		menuService.saveOrUpdate(menu);

		// Get the menu
		restMenuMockMvc.perform(get(DEFAULT_API_URL + "{id}", menu.getId()))
			.andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.name").value(DEFAULT_NAME))
			.andExpect(jsonPath("$.data.permission").value(DEFAULT_PERMISSION))
			.andExpect(jsonPath("$.data.icon").value(DEFAULT_ICON))
			.andExpect(jsonPath("$.data.hidden").value(DEFAULT_HIDDEN))
			.andExpect(jsonPath("$.data.cache").value(DEFAULT_CACHE))
			.andExpect(jsonPath("$.data.iframe").value(DEFAULT_IFRAME))
			.andExpect(jsonPath("$.data.parentId").value(anotherMenu.getId()))
			.andExpect(jsonPath("$.data.component").value(DEFAULT_COMPONENT))
			.andExpect(jsonPath("$.data.type").value(DEFAULT_TYPE))
			.andExpect(jsonPath("$.data.path").value(DEFAULT_PATH))
			.andExpect(jsonPath("$.data.description").value(DEFAULT_DESCRIPTION));
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getNonExistingMenu() throws Exception {
		restMenuMockMvc.perform(get("/sys/menu/ddd/unknown"))
			.andExpect(status().isNotFound());
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void updateMenu() throws Exception {
		// Initialize the database
		menuService.saveOrUpdate(menu);
		int databaseSizeBeforeUpdate = menuService.list().size();

		// Update the menu
		Menu updatedMenu = menuService.getById(menu.getId());


		MenuDto managedMenuVM = new MenuDto();
		managedMenuVM.setName(UPDATED_NAME);
		managedMenuVM.setPermission(UPDATED_PERMISSION);
		managedMenuVM.setIcon(UPDATED_ICON);
		managedMenuVM.setSort(UPDATED_SORT);
		managedMenuVM.setHidden(UPDATED_HIDDEN);
		managedMenuVM.setCache(UPDATED_CACHE);
		managedMenuVM.setIframe(UPDATED_IFRAME);
		managedMenuVM.setParentId(UPDATED_PARENTID);
		managedMenuVM.setComponent(UPDATED_COMPONENT);
		managedMenuVM.setPath(UPDATED_PATH);
		managedMenuVM.setType(UPDATED_TYPE);
		managedMenuVM.setDescription(UPDATED_DESCRIPTION);

		managedMenuVM.setId(updatedMenu.getId());
		restMenuMockMvc.perform(post(DEFAULT_API_URL)
			.contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(managedMenuVM)))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.code").value(CommonConstants.SUCCESS));

		// Validate the Menu in the database
		List<Menu> menuList = menuService.list();
		assertThat(menuList).hasSize(databaseSizeBeforeUpdate);
		Menu testMenu = menuService.getById(updatedMenu.getId());
		assertThat(testMenu.getName()).isEqualTo(UPDATED_NAME);
		assertThat(testMenu.getPermission()).isEqualTo(UPDATED_PERMISSION);
		assertThat(testMenu.getIcon()).isEqualTo(UPDATED_ICON);
		assertThat(testMenu.getHidden()).isEqualTo(UPDATED_HIDDEN);
		assertThat(testMenu.getCache()).isEqualTo(UPDATED_CACHE);
		assertThat(testMenu.getIframe()).isEqualTo(UPDATED_IFRAME);
		assertThat(testMenu.getSort()).isEqualTo(UPDATED_SORT);
		assertThat(testMenu.getParentId()).isEqualTo(UPDATED_PARENTID);
//		assertThat(testMenu.getParentIds()).contains(UPDATED_PARENTID);
		assertThat(testMenu.getComponent()).isEqualTo(UPDATED_COMPONENT);
		assertThat(testMenu.getPath()).isEqualTo(UPDATED_PATH);
		assertThat(testMenu.getType()).isEqualTo(UPDATED_TYPE);
		assertThat(testMenu.isLeaf()).isEqualTo(true);
		assertThat(testMenu.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
		assertThat(testMenu.getDelFlag()).isEqualTo(Menu.FLAG_NORMAL);
	}


	@Test
	@Transactional(rollbackFor = Exception.class)
	public void updateMenuExistingPermission() throws Exception {

		menuService.saveOrUpdate(menu);
		// Update the menu
		Menu updatedMenu = menuService.getById(menu.getId());

		MenuDto managedMenuVM = new MenuDto();
		managedMenuVM.setName(DEFAULT_ANOTHER_NAME);
		managedMenuVM.setIcon(DEFAULT_ANOTHER_ICON);
		managedMenuVM.setParentId(DEFAULT_ANOTHER_PARENTID);
		managedMenuVM.setPermission(DEFAULT_ANOTHER_PERMISSION);
		managedMenuVM.setHidden(DEFAULT_HIDDEN);
		managedMenuVM.setCache(DEFAULT_CACHE);
		managedMenuVM.setIframe(DEFAULT_IFRAME);
		managedMenuVM.setSort(DEFAULT_SORT);
		managedMenuVM.setComponent(DEFAULT_COMPONENT);
		managedMenuVM.setType(DEFAULT_TYPE);
		managedMenuVM.setPath(DEFAULT_PATH);
		managedMenuVM.setDescription(DEFAULT_DESCRIPTION);
		managedMenuVM.setId(updatedMenu.getId());
		restMenuMockMvc.perform(post(DEFAULT_API_URL)
			.contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(managedMenuVM)))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.code").value(CommonConstants.FAIL))
			.andExpect(jsonPath("$.message").isNotEmpty());

		// Update the menu
		Menu updatedMenuAfter = menuService.getById(menu.getId());
		assertThat(updatedMenuAfter.getPermission()).isEqualTo(updatedMenu.getPermission());
	}


	@Test
	@Transactional(rollbackFor = Exception.class)
	public void deleteMenu() throws Exception {
		// Initialize the database
		menuService.saveOrUpdate(menu);
		long databaseSizeBeforeDelete = menuService.count();

		// Delete the menu
		restMenuMockMvc.perform(delete(DEFAULT_API_URL + "{id}", menu.getId())
			.accept(TestUtil.APPLICATION_JSON_UTF8))
			.andExpect(status().isOk());

		// Validate the database is empty
		long databaseSizeAfterDelete = menuService.count();
		assertThat(databaseSizeAfterDelete == databaseSizeBeforeDelete - 1);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void testMenuEquals() throws Exception {
		TestUtil.equalsVerifier(Menu.class);
		Menu menu1 = new Menu();
		menu1.setId("1");
		menu1.setName("Menu1");
		Menu menu2 = new Menu();
		menu2.setId(menu1.getId());
		menu2.setName(menu1.getName());
		assertThat(menu1).isEqualTo(menu2);
		menu2.setId("2");
		menu2.setName("Menu2");
		assertThat(menu1).isNotEqualTo(menu2);
		menu1.setId(null);
		assertThat(menu1).isNotEqualTo(menu2);
	}

}
