// Function to create a toast notification
function createToast(type, message) {
    const toastContainer = document.createElement('div');
    toastContainer.className = "flex items-center w-full max-w-xs p-4 mb-4 text-gray-500 bg-white rounded-lg shadow dark:text-gray-400 dark:bg-gray-800";
    toastContainer.role = "alert";

    let iconClass, iconPath, bgColor, iconColor;
    
    switch (type) {
        case 'success':
            iconClass = "text-green-500 bg-green-100 dark:bg-green-800 dark:text-green-200";
            iconPath = "M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5Zm3.707 8.207-4 4a1 1 0 0 1-1.414 0l-2-2a1 1 0 0 1 1.414-1.414L9 10.586l3.293-3.293a1 1 0 0 1 1.414 1.414Z";
            break;
        case 'error':
            iconClass = "text-red-500 bg-red-100 dark:bg-red-800 dark:text-red-200";
            iconPath = "M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5Zm3.707 11.793a1 1 0 1 1-1.414 1.414L10 11.414l-2.293 2.293a1 1 0 0 1-1.414-1.414L8.586 10 6.293 7.707a1 1 0 0 1 1.414-1.414L10 8.586l2.293-2.293a1 1 0 0 1 1.414 1.414L11.414 10l2.293 2.293Z";
            break;
        case 'warning':
            iconClass = "text-orange-500 bg-orange-100 dark:bg-orange-700 dark:text-orange-200";
            iconPath = "M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM10 15a1 1 0 1 1 0-2 1 1 0 0 1 0 2Zm1-4a1 1 0 0 1-2 0V6a1 1 0 0 1 2 0v5Z";
            break;
        default:
            console.error('Invalid toast type');
            return;
    }

    toastContainer.innerHTML = `
        <div class="inline-flex items-center justify-center flex-shrink-0 w-8 h-8 ${iconClass} rounded-lg">
            <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 20 20">
                <path d="${iconPath}"/>
            </svg>
        </div>
        <div class="ms-3 text-sm font-normal">${message}</div>
        <button type="button" class="ms-auto -mx-1.5 -my-1.5 bg-white text-gray-400 hover:text-gray-900 rounded-lg focus:ring-2 focus:ring-gray-300 p-1.5 hover:bg-gray-100 inline-flex items-center justify-center h-8 w-8 dark:text-gray-500 dark:hover:text-white dark:bg-gray-800 dark:hover:bg-gray-700" aria-label="Close" onclick="this.parentElement.remove()">
            <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
            </svg>
        </button>
    `;

    // Add the toast to the DOM
    document.body.appendChild(toastContainer);

    // Remove the toast after 3 seconds
    setTimeout(() => {
        toastContainer.remove();
    }, 3000);
}

// Function to show a success message
function showSuccessMessage(message) {
    createToast('success', message);
}

// Function to show an error message
function showErrorMessage(message) {
    createToast('error', message);
}

// Function to show a warning message
function showWarningMessage(message) {
    createToast('warning', message);
}
