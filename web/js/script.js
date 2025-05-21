// Hàm phụ để đánh dấu mục menu đang hoạt động và quản lý dropdown
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

// Hàm phụ để đóng thanh bên trên thiết bị di động
function closeSidebarOnMobile() {
    if (window.innerWidth <= 768) {
        const sidebar = document.getElementById('sidebar');
        if (sidebar) sidebar.classList.remove('active');
    }
}

// Định nghĩa danh mục, sản phẩm và hình ảnh
const categoryData = {
    'Búa': {
        products: [
            { name: 'Búa đóng đinh', image: 'https://example.com/images/hammer-nail.jpg' },
            { name: 'Búa gõ', image: '' },
            { name: 'Búa cao su', image: '' },
            { name: 'Búa thợ rèn', image: '' }
        ],
        image: 'img/bua.jpg'
    },
    'Gạch': {
        products: [
            { name: 'Gạch đỏ', image: 'https://example.com/images/red-brick.jpg' },
            { name: 'Gạch bê tông', image: '' },
            { name: 'Gạch men', image: '' }
        ],
        image: 'img/gach.jpg'
    },
    'Bay': {
        products: [
            { name: 'Bay xây', image: 'https://example.com/images/trowel-build.jpg' },
            { name: 'Bay trát', image: '' },
            { name: 'Bay hoàn thiện', image: '' }
        ],
        image: 'img/bay.jpeg'
    },
    'Kìm': {
        products: [
            { name: 'Kìm cắt', image: '' },
            { name: 'Kìm mũi nhọn', image: 'https://example.com/images/needle-nose-pliers.jpg' },
            { name: 'Kìm đa năng', image: '' },
            { name: 'Kìm bấm', image: '' }
        ],
        image: 'img/kim.jpg '
    },
    'Đinh': {
        products: [
            { name: 'Đinh sắt', image: 'https://example.com/images/iron-nails.jpg' },
            { name: 'Đinh thép', image: '' },
            { name: 'Đinh vít', image: '' }
        ],
        image: 'img/dinh.png'
    },
    'Cát': {
        products: [
            { name: 'Cát xây', image: 'https://example.com/images/building-sand.jpg' },
            { name: 'Cát san lấp', image: '' },
            { name: 'Cát vàng', image: '' }
        ],
        image: 'img/cát.jpg'
    },
    'Đá': {
        products: [
            { name: 'Đá 1x2', image: 'https://example.com/images/stone-1x2.jpg' },
            { name: 'Đá 4x6', image: '' },
            { name: 'Đá mi', image: '' }
        ],
        image: 'img/da.jpg'
    },
    'Xi măng': {
        products: [
            { name: 'Xi măng trắng', image: '' },
            { name: 'Xi măng đen', image: '' },
            { name: 'Xi măng PCB40', image: '' }
        ],
        image: 'img/xi_mang.png'
    },
    'Gỗ': {
        products: [
            { name: 'Gỗ thông', image: '' },
            { name: 'Gỗ lim', image: '' },
            { name: 'Gỗ sồi', image: '' }
        ],
        image: ''
    },
    'Sắt': {
        products: [
            { name: 'Sắt phi 6', image: '' },
            { name: 'Sắt phi 8', image: '' },
            { name: 'Sắt hộp', image: '' }
        ],
        image: 'img/sat.jpg'
    },
    'Thép': {
        products: [
            { name: 'Thép tròn', image: '' },
            { name: 'Thép vuông', image: '' },
            { name: 'Thép cán nóng', image: '' }
        ],
        image: ''
    },
    'Ống nước': {
        products: [
            { name: 'Ống PVC', image: '' },
            { name: 'Ống PPR', image: '' },
            { name: 'Ống HDPE', image: '' }
        ],
        image: ''
    },
    'Dây điện': {
        products: [
            { name: 'Dây đơn', image: '' },
            { name: 'Dây đôi', image: '' },
            { name: 'Dây cáp', image: '' }
        ],
        image: ''
    },
    'Sơn': {
        products: [
            { name: 'Sơn nước', image: '' },
            { name: 'Sơn dầu', image: '' },
            { name: 'Sơn chống thấm', image: '' }
        ],
        image: ''
    },
    'Gạch men': {
        products: [
            { name: 'Gạch lát nền', image: '' },
            { name: 'Gạch ốp tường', image: '' },
            { name: 'Gạch mosaic', image: '' }
        ],
        image: ''
    },
    'Vữa': {
        products: [
            { name: 'Vữa xây', image: '' },
            { name: 'Vữa trát', image: '' },
            { name: 'Vữa tự chảy', image: '' }
        ],
        image: ''
    },
    'Kính': {
        products: [
            { name: 'Kính cường lực', image: '' },
            { name: 'Kính thường', image: '' },
            { name: 'Kính mờ', image: '' }
        ],
        image: ''
    },
    'Dụng cụ cầm tay': {
        products: [
            { name: 'Cưa tay', image: '' },
            { name: 'Cưa máy', image: 'https://example.com/images/chainsaw.jpg' },
            { name: 'Khoan tay', image: '' },
            { name: 'Thước dây', image: '' }
        ],
        image: 'https://example.com/images/chainsaw.jpg'
    },
    'Giàn giáo': {
        products: [
            { name: 'Giàn giáo khung', image: 'https://example.com/images/scaffolding.jpg' },
            { name: 'Giàn giáo nêm', image: '' },
            { name: 'Giàn giáo di động', image: '' }
        ],
        image: 'https://example.com/images/scaffolding.jpg'
    },
    'Máy hàn': {
        products: [
            { name: 'Máy hàn Hồng Ký HK-200H', image: 'https://example.com/images/welding-machine.jpg' },
            { name: 'Máy hàn TIG', image: '' },
            { name: 'Máy hàn MIG', image: '' }
        ],
        image: 'https://example.com/images/welding-machine.jpg'
    }
};

// Hiển thị danh sách danh mục với phân trang
function showMaterialCategories(page = 1) {
    const contentArea = document.getElementById('contentArea');
    if (!contentArea) {
        console.error("Không tìm thấy contentArea");
        return;
    }
    const categories = Object.keys(categoryData);
    const itemsPerPage = 5;
    const totalPages = Math.ceil(categories.length / itemsPerPage);
    const startIndex = (page - 1) * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;
    const paginatedCategories = categories.slice(startIndex, endIndex);

    let html = '<div class="content-card"><h2>Danh mục vật tư</h2><ul class="category-list">';
    paginatedCategories.forEach(category => {
        const imageSrc = categoryData[category].image || 'https://example.com/images/placeholder.jpg';
        html += `
            <li>
                <a href="#" onclick="showProducts('${category}', 1)">
                    <img src="${imageSrc}" alt="${category}" class="category-image">
                    ${category}
                </a>
            </li>`;
    });
    html += '</ul>';
    html += `<div class="pagination">
        <button onclick="showMaterialCategories(${page - 1})" ${page === 1 ? 'disabled' : ''}>Trang trước</button>
        <span>Trang ${page} / ${totalPages}</span>
        <button onclick="showMaterialCategories(${page + 1})" ${page === totalPages ? 'disabled' : ''}>Trang sau</button>
    </div></div>`;
    contentArea.innerHTML = html;
}

// Hiển thị sản phẩm của danh mục với phân trang
function showProducts(category, page = 1) {
    const contentArea = document.getElementById('contentArea');
    if (!contentArea) {
        console.error("Không tìm thấy contentArea");
        return;
    }
    const products = categoryData[category]?.products || [];
    const itemsPerPage = 5;
    const totalPages = Math.ceil(products.length / itemsPerPage);
    const startIndex = (page - 1) * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;
    const paginatedProducts = products.slice(startIndex, endIndex);

    let html = `<div class="content-card"><h2>${category}</h2><a href="#" onclick="showMaterialCategories(1)">Quay lại danh mục</a><ul class="product-list">`;
    paginatedProducts.forEach(product => {
        const imageSrc = product.image || 'https://example.com/images/placeholder.jpg';
        html += `
            <li>
                <img src="${imageSrc}" alt="${product.name}" class="product-image">
                ${product.name}
            </li>`;
    });
    html += '</ul>';
    html += `<div class="pagination">
        <button onclick="showProducts('${category}', ${page - 1})" ${page === 1 ? 'disabled' : ''}>Trang trước</button>
        <span>Trang ${page} / ${totalPages}</span>
        <button onclick="showProducts('${category}', ${page + 1})" ${page === totalPages ? 'disabled' : ''}>Trang sau</button>
    </div></div>`;
    contentArea.innerHTML = html;
}

function login() {
    const loginPage = document.getElementById('loginPage');
    if (loginPage) {
        loginPage.innerHTML = '<p style="color: #4a90e2; text-align: center;">Đang đăng nhập...</p>';
        setTimeout(() => {
            window.location.href = 'Manager.html';
        }, 500);
    } else {
        console.error("Không tìm thấy phần tử loginPage");
        window.location.href = 'Manager.html';
    }
}

function logout() {
    document.querySelectorAll('.dropdown').forEach(d => d.classList.remove('active'));
    document.querySelectorAll('.sidebar ul li a').forEach(a => a.classList.remove('active'));
    window.location.href = 'login.html';
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

function showContent(title, element) {
    const contentArea = document.getElementById('contentArea');
    if (!contentArea) {
        console.error("Không tìm thấy contentArea");
        return;
    }
    if (title === 'Xem danh mục vật tư') {
        showMaterialCategories(1);
    } else {
        contentArea.innerHTML = `
            <div class="content-card">
                <h2>${title}</h2>
                <p>Đây là nội dung của chức năng "${title}".</p>
            </div>
        `;
    }
    highlightMenuItem(element);
    closeSidebarOnMobile();
}

function showProfile() {
    const contentArea = document.getElementById('contentArea');
    if (!contentArea) {
        console.error("Không tìm thấy contentArea");
        return;
    }
    contentArea.innerHTML = `
        <div class="content-card">
            <h2>Thông tin cá nhân</h2>
            <div class="profile-card">
                <h3><i class="fas fa-user-circle"></i> Hồ sơ cá nhân</h3>
                <div class="info-row">
                    <label>Họ và tên:</label>
                    <span>Nguyễn Văn A</span>
                </div>
                <div class="info-row">
                    <label>Email:</label>
                    <span>nguyenvana@example.com</span>
                </div>
                <div class="info-row">
                    <label>Số điện thoại:</label>
                    <span>0123 456 789</span>
                </div>
                <div class="info-row">
                    <label>Vai trò:</label>
                    <span>Quản lý</span>
                </div>
            </div>
        </div>
    `;
    const profileLink = document.querySelector('.sidebar ul li a[onclick="showProfile()"]');
    highlightMenuItem(profileLink);
    closeSidebarOnMobile();
}

function showPermissions() {
    const contentArea = document.getElementById('contentArea');
    if (!contentArea) {
        console.error("Không tìm thấy contentArea");
        return;
    }
    const permissionLink = document.querySelector('.sidebar ul li a[onclick="showPermissions()"]');
    highlightMenuItem(permissionLink);
    closeSidebarOnMobile();
}

function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    if (!sidebar) {
        console.error("Không tìm thấy sidebar");
        return;
    }
    sidebar.classList.toggle('active');
}