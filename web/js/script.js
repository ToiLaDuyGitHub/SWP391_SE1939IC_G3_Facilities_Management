function toggleSection(sectionId) {
    const sections = [
        'welcomeSection',
        'changePasswordSection',
        'profileSection',
        'categoryListSection',
        'categoryBuaSection',
        'categoryGachSection',
        'categoryBaySection',
        'categoryKimSection',
        'categoryDinhSection',
        'categoryCatSection',
        'categoryDaSection',
        'categoryXiMangSection',
        'categoryGoSection',
        'categorySatSection',
        'categoryThepSection',
        'categoryOngNuocSection',
        'categoryDayDienSection',
        'categorySonSection',
        'categoryGachMenSection',
        'categoryVuaSection',
        'categoryKinhSection',
        'categoryDungCuCamTaySection',
        'categoryGianGiaoSection',
        'categoryMayHanSection',
        'genericSection',
        'materialListSection',
        'addMaterialSection',
        'userList',
        'addUser'
    ];
    sections.forEach(id => {
        const section = document.getElementById(id);
        if (section) {
            section.classList.toggle('hidden', id !== sectionId);
        }
    });
}

function showContent(sectionId, element) {
    const genericSection = document.getElementById('genericSection');
    if (!genericSection) {
        console.error("Không tìm thấy genericSection");
        return;
    }

    const sectionMap = {
        editUser: "Sửa thông tin người dùng",
        addCategory: "Thêm mới danh mục vật tư",
        materialList: "Xem danh sách vật tư",
        addMaterial: "Thêm mới vật tư"
    };

    if (sectionId === 'materialList') {
        toggleSection('materialListSection');
    } else if (sectionId === 'addMaterial') {
        toggleSection('addMaterialSection');
    } else if (sectionMap[sectionId]) {
        genericSection.innerHTML = `
            <h2>${sectionMap[sectionId]}</h2>
            <p>Đây là nội dung của chức năng "${sectionMap[sectionId]}".</p>
        `;
        toggleSection('genericSection');
    } else {
        toggleSection(sectionId);
    }

    highlightMenuItem(element);
    closeSidebarOnMobile();
}



function openEditModal() {
    const modal = document.getElementById('editModal');
    const overlay = document.getElementById('editModalOverlay');
    if (!modal || !overlay) {
        console.error("Không tìm thấy modal hoặc overlay");
        return;
    }

    modal.style.display = 'block';
    overlay.style.display = 'block';
    setTimeout(() => {
        modal.classList.add('show');
        overlay.classList.add('show');
    }, 10);
}

function closeEditModal() {
    const modal = document.getElementById('editModal');
    const overlay = document.getElementById('editModalOverlay');
    modal.classList.remove('show');
    overlay.classList.remove('show');
    setTimeout(() => {
        modal.style.display = 'none';
        overlay.style.display = 'none';
    }, 300);
}

function saveChanges() {
    const form = document.querySelector('#editModal form');
    if (form) {
        form.submit(); 
    } else {
        console.error("Không tìm thấy form trong modal");
    }
}

function handleFormSubmit(event) {
    event.preventDefault();
    const form = document.getElementById('addMaterialForm');
    const successMessage = document.getElementById('successMessage');
    if (form && successMessage) {
        console.log("Form data:", new FormData(form));
        successMessage.classList.remove('hidden');
        setTimeout(() => {
            successMessage.classList.add('hidden');
            form.reset();
        }, 3000);
    }
}

function resetForm() {
    const form = document.getElementById('addMaterialForm');
    const successMessage = document.getElementById('successMessage');
    if (form) {
        form.reset();
    }
    if (successMessage) {
        successMessage.classList.add('hidden');
    }
}

window.onclick = function(event) {
    if (event.target.classList.contains('modal-overlay')) {
        closeEditModal();
    }
};

function highlightMenuItem(element) {
    if (!element) return;
    document.querySelectorAll('.sidebar ul li a').forEach(a => a.classList.remove('active'));
    element.classList.add('active');
    const dropdown = element.closest('.dropdown');
    if (dropdown) {
        document.querySelectorAll('.dropdown').forEach(d => {
            if (d !== dropdown) d.classList.remove('active');
        });
        dropdown.classList.add('active');
    }
}

function closeSidebarOnMobile() {
    if (window.innerWidth <= 768) {
        const sidebar = document.getElementById('sidebar');
        if (sidebar) sidebar.classList.remove('active');
    }
}

function login() {
    const loginPage = document.getElementById('loginPage');
    if (loginPage) {
        loginPage.innerHTML = '<p style="color: #4a90e2; text-align: center;">Đang đăng nhập...</p>';
        setTimeout(() => {
            window.location.href = 'home.jsp';
        }, 500);
    } else {
        console.error("Không tìm thấy phần tử loginPage");
        window.location.href = 'home.jsp';
    }
}

function logout() {
    document.querySelectorAll('.dropdown').forEach(d => d.classList.remove('active'));
    document.querySelectorAll('.sidebar ul li a').forEach(a => a.classList.remove('active'));
    window.location.href = 'login.jsp';
}

function toggleDropdown(element) {
    const dropdown = element.parentElement;
    if (!dropdown) return;
    const isActive = dropdown.classList.contains('active');
    document.querySelectorAll('.dropdown').forEach(d => {
        if (d !== dropdown) d.classList.remove('active');
    });
    dropdown.classList.toggle('active', !isActive);
}

function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    if (!sidebar) {
        console.error("Không tìm thấy sidebar");
        return;
    }
    sidebar.classList.toggle('active');
}

function showPermissions() {
    const genericSection = document.getElementById('genericSection');
    if (!genericSection) {
        console.error("Không tìm thấy genericSection");
        return;
    }
    const permissionLink = document.querySelector('.sidebar ul li a[onclick="showPermissions()"]');
    highlightMenuItem(permissionLink);
    closeSidebarOnMobile();
}

function showMaterialDetail(name, category, subcategory, supplier, quantity, image) {
    document.getElementById('materialName').value = name;
    document.getElementById('category').value = category;
    document.getElementById('subcategory').value = subcategory;
    document.getElementById('supplier').value = supplier;
    document.getElementById('quantity').value = quantity;
    document.getElementById('imageUrl').value = image;
    document.querySelector('#editModal img').src = image;

    openEditModal();
}
