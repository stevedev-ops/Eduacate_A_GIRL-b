const FormData = require('form-data');
const fs = require('fs');
const path = require('path');

async function testFileUpload() {
    console.log('\n=== Testing File Upload Validation ===\n');

    // Test 1: Valid image file (create a dummy PNG)
    console.log('Test 1: Uploading valid image file...');
    try {
        // Create a minimal 1x1 PNG
        const pngBuffer = Buffer.from([
            0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A,
            0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
            0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
            0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
            0x89, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x44, 0x41,
            0x54, 0x78, 0x9C, 0x62, 0x00, 0x01, 0x00, 0x00,
            0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00,
            0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
            0x42, 0x60, 0x82
        ]);

        const testImagePath = path.join(__dirname, 'test-image.png');
        fs.writeFileSync(testImagePath, pngBuffer);

        const form = new FormData();
        form.append('image', fs.createReadStream(testImagePath));

        const response = await fetch('http://localhost:3001/api/upload', {
            method: 'POST',
            body: form
        });

        const result = await response.json();

        if (response.ok) {
            console.log('✅ Valid image upload successful:', result.url);
        } else {
            console.log('❌ Valid image upload failed:', result.error);
        }

        // Cleanup
        fs.unlinkSync(testImagePath);
    } catch (error) {
        console.log('❌ Test 1 error:', error.message);
    }

    // Test 2: Invalid file type (text file)
    console.log('\nTest 2: Uploading invalid file type (.txt)...');
    try {
        const testTextPath = path.join(__dirname, 'test-file.txt');
        fs.writeFileSync(testTextPath, 'This is not an image');

        const form = new FormData();
        form.append('image', fs.createReadStream(testTextPath));

        const response = await fetch('http://localhost:3001/api/upload', {
            method: 'POST',
            body: form
        });

        const result = await response.json();

        if (!response.ok) {
            console.log('✅ Invalid file correctly rejected:', result.error);
        } else {
            console.log('❌ Invalid file was accepted (should have been rejected)');
        }

        // Cleanup
        fs.unlinkSync(testTextPath);
    } catch (error) {
        console.log('❌ Test 2 error:', error.message);
    }

    console.log('\n=== Tests Complete ===\n');
}

testFileUpload().catch(console.error);
