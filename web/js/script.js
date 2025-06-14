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
        'Userctr',
        'addUser',
        'userDetail'
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

window.onclick = function (event) {
    if (event.target.classList.contains('modal-overlay')) {
        closeEditModal();
    }
};

function highlightMenuItem(element) {
    if (!element)
        return;
    document.querySelectorAll('.sidebar ul li a').forEach(a => a.classList.remove('active'));
    element.classList.add('active');
    const dropdown = element.closest('.dropdown');
    if (dropdown) {
        document.querySelectorAll('.dropdown').forEach(d => {
            if (d !== dropdown)
                d.classList.remove('active');
        });
        dropdown.classList.add('active');
    }
}

function closeSidebarOnMobile() {
    if (window.innerWidth <= 768) {
        const sidebar = document.getElementById('sidebar');
        if (sidebar)
            sidebar.classList.remove('active');
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
    if (!dropdown)
        return;
    const isActive = dropdown.classList.contains('active');
    document.querySelectorAll('.dropdown').forEach(d => {
        if (d !== dropdown)
            d.classList.remove('active');
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

function showMaterialDetail(name, category, subcategory, supplier, totalQuantity, usableQuantity, brokenQuantity, image, detail) {
            document.getElementById('materialName').textContent = name;
            document.getElementById('category').textContent = category;
            document.getElementById('subcategory').textContent = subcategory;
            document.getElementById('supplier').textContent = supplier;
            document.getElementById('quantity').textContent = totalQuantity;
            document.getElementById('usableQuantity').textContent = usableQuantity;
            document.getElementById('brokenQuantity').textContent = brokenQuantity;
            document.getElementById('detail').textContent = detail;

    const materialImage = document.getElementById('materialImage');
    if (image && image !== 'null') {
        materialImage.src = image;
        materialImage.style.display = 'block';
    } else {
        materialImage.style.display = 'none';
    }

    openEditModal();
}

function setActiveMenu() {
    // Lấy URL hiện tại
    const currentPath = window.location.pathname;

    // Lấy tất cả các thẻ a trong sidebar
    const menuLinks = document.querySelectorAll('.sidebar a');

    // Xóa class active khỏi tất cả các link
    menuLinks.forEach(link => {
        link.classList.remove('active');
    });

    // Tìm và thêm class active cho link phù hợp
    menuLinks.forEach(link => {
        const href = link.getAttribute('href');

        // Kiểm tra nếu URL hiện tại chứa href của link
        if (href && currentPath.includes(href.split('/').pop())) {
            link.classList.add('active');

            // Mở dropdown nếu link nằm trong dropdown
            const dropdownContent = link.closest('.dropdown-content');
            if (dropdownContent) {
                const dropdown = dropdownContent.closest('.dropdown');
                dropdown.classList.add('active');
                dropdownContent.style.display = 'block';
            }
        }
    });
}

// Gọi hàm khi trang được load
document.addEventListener('DOMContentLoaded', setActiveMenu);

// Gọi lại hàm khi URL thay đổi (cho SPA)
window.addEventListener('popstate', setActiveMenu);
function viewCart() {
    // Add logic to navigate to cart page or show cart details
    alert("Xem giỏ hàng (Tổng: ${sessionScope.cartCount != null ? sessionScope.cartCount : 0} sản phẩm)");
    // Replace with actual navigation, e.g., window.location.href = '/cart';
}
