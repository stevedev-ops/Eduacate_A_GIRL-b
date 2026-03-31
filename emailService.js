const nodemailer = require('nodemailer');
require('dotenv').config();

// Create reusable transporter object using the default SMTP transport
const createTransporter = () => {
    return nodemailer.createTransport({
        service: 'gmail', // Use Gmail as requested
        auth: {
            user: process.env.SMTP_EMAIL, // Admin Gmail
            pass: process.env.SMTP_PASSWORD // Google App Password
        }
    });
};

// Helper inside to parse JSON if needed
const parseJson = (data) => {
    if (typeof data === 'string') {
        try { return JSON.parse(data); } catch (e) { return data; }
    }
    return data;
};

const sendOrderConfirmation = async (order) => {
    if (!process.env.SMTP_EMAIL || !process.env.SMTP_PASSWORD) {
        console.warn("SMTP credentials not provided. Order confirmation email bypassed.");
        return false;
    }

    try {
        const transporter = createTransporter();
        const customerInfo = parseJson(order.customer_info) || {};
        const items = parseJson(order.items) || [];
        const orderId = order.id || 'N/A';

        const emailAddress = customerInfo.email;
        if (!emailAddress) {
            console.warn(`Order ${orderId} has no customer email.`);
            return false;
        }

        const itemsHtml = items.map(item => `
            <tr>
                <td style="padding: 10px; border-bottom: 1px solid #eee;"><strong>${item.name}</strong><br><small>${item.category || ''}</small></td>
                <td style="padding: 10px; border-bottom: 1px solid #eee; text-align: center;">${item.quantity || 1}</td>
                <td style="padding: 10px; border-bottom: 1px solid #eee; text-align: right;">$${Number(item.price || item.offerPrice || 0).toFixed(2)}</td>
            </tr>
        `).join('');

        const htmlContent = `
            <div style="font-family: Arial, sans-serif; max-w-lg: 600px; margin: 0 auto; color: #333; line-height: 1.6;">
                <div style="text-align: center; padding: 20px 0; background-color: #fce7f3; border-radius: 8px 8px 0 0;">
                    <h1 style="color: #db2777; margin: 0;">Thank You For Your Order!</h1>
                </div>
                <div style="padding: 20px; border: 1px solid #fce7f3; border-top: none; border-radius: 0 0 8px 8px;">
                    <p>Hi ${customerInfo.name || 'Friend'},</p>
                    <p>We successfully received your order (<strong>#EARG-${orderId}</strong>). Here is a summary of your contribution:</p>
                    
                    <table style="width: 100%; border-collapse: collapse; margin-top: 20px;">
                        <thead>
                            <tr style="background-color: #f9fafb;">
                                <th style="padding: 10px; text-align: left; border-bottom: 2px solid #ddd;">Item</th>
                                <th style="padding: 10px; text-align: center; border-bottom: 2px solid #ddd;">Qty</th>
                                <th style="padding: 10px; text-align: right; border-bottom: 2px solid #ddd;">Price</th>
                            </tr>
                        </thead>
                        <tbody>
                            ${itemsHtml}
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="2" style="padding: 10px; text-align: right; font-weight: bold;">Total:</td>
                                <td style="padding: 10px; text-align: right; font-weight: bold; color: #db2777;">$${Number(order.total || 0).toFixed(2)}</td>
                            </tr>
                        </tfoot>
                    </table>

                    <p style="margin-top: 30px;">Every purchase drives our mission forward. If you have any questions, reply to this email.</p>
                    <p style="font-weight: bold; color: #db2777;">With gratitude,<br>The Educate A Rural Girl Team</p>
                </div>
            </div>
        `;

        await transporter.sendMail({
            from: `"Educate A Rural Girl" <${process.env.SMTP_EMAIL}>`,
            to: emailAddress,
            subject: `Order Confirmation #EARG-${orderId}`,
            html: htmlContent,
        });

        console.log(`Confirmation email sent to ${emailAddress} for order ${orderId}`);
        return true;
    } catch (err) {
        console.error("Failed to send order confirmation:", err);
        return false;
    }
};

const sendAdminNotification = async (order) => {
    if (!process.env.SMTP_EMAIL || !process.env.SMTP_PASSWORD) return false;
    const adminEmail = process.env.ADMIN_EMAIL || process.env.SMTP_EMAIL;

    try {
        const transporter = createTransporter();
        const customerInfo = parseJson(order.customer_info) || {};
        const items = parseJson(order.items) || [];
        const orderId = order.id || 'N/A';

        const htmlContent = `
            <div style="font-family: Arial, sans-serif; color: #333;">
                <h2>New Order Received: #EARG-${orderId}</h2>
                <p><strong>Customer Name:</strong> ${customerInfo.name}</p>
                <p><strong>Email:</strong> ${customerInfo.email}</p>
                <p><strong>Total Paid:</strong> $${Number(order.total || 0).toFixed(2)}</p>
                <h3>Items:</h3>
                <ul>
                    ${items.map(item => `<li>${item.quantity || 1}x ${item.name} ($${Number(item.price || item.offerPrice || 0).toFixed(2)})</li>`).join('')}
                </ul>
                <p>Check your backend database or dashboard to process this order.</p>
            </div>
        `;

        await transporter.sendMail({
            from: `"Website Orders" <${process.env.SMTP_EMAIL}>`,
            to: adminEmail,
            subject: `New Order Received - #EARG-${orderId} - $${Number(order.total || 0).toFixed(2)}`,
            html: htmlContent,
        });

        console.log(`Admin notification sent for order ${orderId}`);
        return true;
    } catch (err) {
        console.error("Failed to send admin notification:", err);
        return false;
    }
};

module.exports = {
    sendOrderConfirmation,
    sendAdminNotification
};
