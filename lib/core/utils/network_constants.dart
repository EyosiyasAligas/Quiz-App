const authBaseUrl = 'https://opentdb.com/';

String getAllQuestions = '${authBaseUrl}api.php?amount=10';

String getAllCategories = '${authBaseUrl}api_category.php';

String getQuestionsByCategory(int categoryId) =>
    '${authBaseUrl}api.php?amount=10&category=$categoryId';

String getNumberOfQuestionsByCategory(int categoryId) =>
    '${authBaseUrl}api_count.php?category=$categoryId';

String getNumberOfAllQuestions = '${authBaseUrl}api_count_global.php';
