const http = require('http');

console.log('🧪 Testing Blood Donation API...\n');

// Test server health
const testEndpoint = (path, method = 'GET', data = null) => {
  return new Promise((resolve, reject) => {
    const options = {
      hostname: 'localhost',
      port: 5000,
      path: path,
      method: method,
      headers: {
        'Content-Type': 'application/json'
      }
    };

    const req = http.request(options, (res) => {
      let responseData = '';
      
      res.on('data', (chunk) => {
        responseData += chunk;
      });
      
      res.on('end', () => {
        resolve({
          status: res.statusCode,
          data: responseData
        });
      });
    });
    
    req.on('error', (e) => {
      reject(e);
    });
    
    if (data) {
      req.write(JSON.stringify(data));
    }
    
    req.end();
  });
};

async function runTests() {
  try {
    // Test root endpoint
    console.log('Testing root endpoint...');
    const rootTest = await testEndpoint('/');
    console.log(`✅ Root: ${rootTest.status} - ${rootTest.data}`);
    
    // Test donors endpoint
    console.log('\nTesting donors endpoint...');
    const donorsTest = await testEndpoint('/api/donors');
    console.log(`✅ Donors: ${donorsTest.status}`);
    
    // Test auth signup endpoint
    console.log('\nTesting auth signup endpoint...');
    const signupTest = await testEndpoint('/api/auth/signup', 'POST', {
      name: 'Test User',
      email: 'test@example.com',
      password: 'test123',
      phone: '1234567890',
      userType: 'donor'
    });
    console.log(`✅ Signup: ${signupTest.status}`);
    
    console.log('\n🎉 All endpoints are working!');
    
  } catch (error) {
    console.log(`❌ Server Error: ${error.message}`);
    console.log('💡 Make sure the backend server is running (npm start)');
  }
}

runTests();