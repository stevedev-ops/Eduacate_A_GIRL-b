const sqlite3 = require('sqlite3').verbose();
const path = require('path');

const dbPath = path.resolve(__dirname, 'database.sqlite');
const db = new sqlite3.Database(dbPath);

const products = [
    {
        id: "p1",
        name: "Artisan Woven Basket",
        price: 45.00,
        category: "Handmade Crafts",
        rating: 5,
        reviews: 48,
        description: "Crafted with care and tradition, this versatile basket brings natural warmth to any room. Use it for storage, as a planter cover, or simply as a piece of art. Each purchase empowers the artisan who created it.",
        material: "100% natural sisal fiber",
        dimensions: '12" H x 14" W (approx)',
        origin: "Machakos, Kenya",
        impact: "Provides income for 3 artisans",
        details: JSON.stringify([
            "Dye: Organic vegetable dyes",
            "Handmade in Machakos, Kenya"
        ]),
        story: JSON.stringify({
            text: "\"Weaving has allowed me to send my two daughters to secondary school. Every basket carries a piece of my hope for their future.\"",
            author: "Sarah, Lead Weaver",
            image: "https://lh3.googleusercontent.com/aida-public/AB6AXuATZbM9c7e-F0wNGB_r3sW1ukvj9xx0DHLEt599wE-ShuZw8ZoS_I0CI4MrRvZy4rkj7DEGZ3LDXK5--IrHo1dC3c8mDYA3505mtQKcX3EZq4_SJ9JWDu64cs2Ms88z4g4NQynynDnXb0DjtAFBlFwO5IqVw-H-pMraTRbkTEAnOl-LSrKZP-2B7ovVXyKJj0v3RJk-it6jHD_4abIkogQdr77bTPhKdiUneZ3c_1iFRE9DBPlQl2DEsQX0q4d7WCuD5jgLIC4o3KY"
        }),
        images: JSON.stringify([
            "https://lh3.googleusercontent.com/aida-public/AB6AXuDcGOfwzn2lLP0O9xpdkKhevvV2An0zVzIRbgX6LKTTOeK0uG8wRpHM1BB-67hO4FKMol1T1xc8U8kOqiHubqQgf_2AB3IFl0qXw_QhZExBC2ANi-621sEA397h59bmwj9UuRvbQQYcZzCB7HwL5nUVmP-_AbdMVxe0LeWMdABazFl6vCUsukazKJC3EpWEKS47BCB6_RvI2ptJPOMzNy1ljfO_m9DFF2fqrWZK2pQ5X5YzvC_hIsYatsMWgNJvuK6yagorNsVhkKk",
            "https://lh3.googleusercontent.com/aida-public/AB6AXuBY3T2kVH6m-QMOesXUrbOISgenYku6fG2cBICKgs3_j-jhn4YYItZ8As2nnH8nm6tMVii5TfOFxzQ9N1vAORnLVVk5SPimSco1CCFZbYpgxLQ4NcoL0a1Ri7F3kQ4FCNRdZI7H206PKGFXY42JCybCtU7w0cRedB-QVVsVlgIKvVhN5ew9IIQxh_9-obWB0JNnIi0E7RGKg_K9Rw1T-mbzD-SYCcZCPknRvs42_EXYREHzqz-YvR8Na4BrkQKwgnDeYrXDoc7Xpeg",
            "https://lh3.googleusercontent.com/aida-public/AB6AXuByzExPPVpAnTST0XeGkK2DarmStotqJKN5dgg5g5JMmSWycbqzJDf7pwHcLd8hZpL2WCMpSJDu-OEL1wp9USvAhIJp64zbqlzhs0gUuHnv9qGm0NaMeE9sZA9x68r5AdGBMJjgN-ZiLfB-twjVq8XHGNQxCFqwjiA5VY2bL5i46iCCH4EfWzHlvIo4OfsSKI-1_3GoljFOZr1do_WhIeDxLPPxs9cgSIWmrf4IEXadUZZxCZ34K1cX3-K5hAhVIWmIhnLtW8OsOKc"
        ]),
        stock: 12,
        offerPrice: null
    },
    {
        id: "p2",
        name: "Organic Cotton Tote Bag",
        price: 25.00,
        category: "Sustainable Apparel",
        rating: 5,
        reviews: 124,
        description: "Carry your essentials in style while saving the planet. This durable tote is made from 100% organic cotton and features a minimalist design inspired by nature.",
        material: "100% Organic Cotton",
        dimensions: "16\" H x 14\" W",
        origin: "Ethically made in India",
        impact: "Saves 500g of plastic waste",
        details: JSON.stringify([
            "Reinforced handles",
            "Machine washable"
        ]),
        story: JSON.stringify({
            text: "\"Switching to organic farming saved our soil. This bag represents a cleaner earth for my children.\"",
            author: "Rajesh, Cotton Farmer",
            image: "https://lh3.googleusercontent.com/aida-public/AB6AXuDlXFh0IymZmXpXIty_9EXE17p5nYSYjxy9wLt9fI-sziNc1ff7N8NhlqD-n12WUdCYhfpoBxf-DWaRcLAywRpglhCjzjgljXVhiIPMSHU0y8o0DCQksQWSWAiDW5ZIqehW7_7akGmeVz5R-mExHMf1tyEeyv1HnSx1Q_YaAFlyppQjd5ss7YaB-Wof67SrKNmdkRGs1eUdnKBjY47gBxkIhgmfCV2WJPpJ8CgeIBeK-IihdKnC8Fj5E9Vs_sDhVsjYX4n2U5zzr20"
        }),
        images: JSON.stringify([
            "https://lh3.googleusercontent.com/aida-public/AB6AXuDPS-rXHURKypGuV60zLR1IW1715_lVDf9ZaJC-y5JBy8kTXkWv_0WNW4_QY03-DTbwj8QZqMoGvDNEhVlXMHh2Fl1u0soYKa2-Ilo_RCk1vgaTcW9hNEabaF3FOaD0X7r8pt5uOy3o3CLG4sCJMzPT2ncYsVhnhqOHZ-XN7VrFackHO0ODaP9DOZ1Uuv9Q3qOEdkQrajpNGo7DH78J2FkHrs0ydGyWNRjC0aB8eCqczEBN56wif0HawNawePq_SHoCpS3Cricf188"
        ]),
        stock: 25
    },
    {
        id: "p3",
        name: "Brass Pendant Necklace",
        price: 32.00,
        category: "Jewelry",
        rating: 4.5,
        reviews: 32,
        description: "A stunning piece of handcrafted jewelry that adds elegance to any outfit. Made from recycled brass by skilled artisans.",
        material: "Recycled Brass",
        dimensions: "Adjustable chain length",
        origin: "Jaipur, India",
        impact: "Supports fair wages for artisans",
        details: JSON.stringify([
            "Lead-free and nickel-free",
            "Polished finish"
        ]),
        story: JSON.stringify({
            text: "\"I am proud to keep my family's jewelry-making tradition alive while earning a fair wage.\"",
            author: "Priya, Jeweler",
            image: "https://lh3.googleusercontent.com/aida-public/AB6AXuAmlTSo0Is3iJzJThjbYB8qhWU_Rc_bu627pbMmsBRoix29h6N5amuns32RtOfteeetH2XTbb80-E-uZhFwIPlezilN4WU8qTwha9fLAXx8e8sesCUYIB_pOX-bqGVOdwxdVZw40JaXnYG6S4JJY7QSF3ijStC1BgOnUqy2SIE1BogERJgaUllUMS3HsydO9qXG_RXytKtARng2ftG_bpN-gG7GtT_amtZd3PghQUIN24fudwwdd4_UrFZP64aSp59ioubBytyQWmY"
        }),
        images: JSON.stringify([
            "https://lh3.googleusercontent.com/aida-public/AB6AXuAoUHBqrhGWAbJsD9e1pqtew15yRYV22Pd1oCUG6mC4BKU35u-SfPxPgvbzoIPMl02M0XQ04fJJyzsbd2L5i46iCCH4EfWzHlvIo4OfsSKI-1_3GoljFOZr1do_WhIeDxLPPxs9cgSIWmrf4IEXadUZZxCZ34K1cX3-K5hAhVIWmIhnLtW8OsOKc"
        ]),
        stock: 5,
        offerPrice: null
    },
    {
        id: "p4",
        name: "Reusable Life Bottle",
        price: 30.00,
        category: "Eco-Friendly",
        rating: 5,
        reviews: 89,
        description: "Stay hydrated and reduce plastic use with our premium stainless steel water bottle. Keeps drinks cold for 24 hours.",
        material: "Food-grade Stainless Steel",
        dimensions: "500ml / 17oz",
        origin: "Responsibly manufactured in China",
        impact: "Funds clean water projects",
        details: JSON.stringify([
            "Double-wall insulation",
            "BPA-free"
        ]),
        story: null,
        images: JSON.stringify([
            "https://lh3.googleusercontent.com/aida-public/AB6AXuBzpOPEpjll1_hPZvfm6S3_guMf4zD4uWedF4wMqcXVqNBIFKisD9TcKKhMLfLamuRJp7MV7dPz3ZVQPEON6fMpNkOgOlDpUPssFfkFqTofYrA61sgc4qL_flM-oaF2XZ_DjtSMztuo9Lc5S111yfQY0_HWxvbhCoeNs-UlBbIK46f4INaZyF5fj-qTfaKMMI1gulMJRpQfEd_j3-W4tEwQdA0A1u8LfWmwXKs8y5KXEWoBv-sflNXTzfahbi27F0UGG6u5WZSEg"
        ]),
        stock: 50,
        offerPrice: 25.00
    }
];

const galleryImages = [
    "https://lh3.googleusercontent.com/aida-public/AB6AXuCeNpgQ1Z-gZk5SLrWR-scqmjnywuWx-1KRnrSG-RIgARm8zqgSfGY1A9KWvuq7T1_Q-7BuVdcUqz_-OSmaPS8WQT4l3GAz0wyHqlpi_tejkH1uQCzNm59MF2ecybxjoIWyMTSchwkdYu9P3WQ3bnk88dTL1lcfAMdXhHzIsqc1tHJatVvauur28mZ8TcNh-OdnK6k-cfTkXmUo4iuldRV6_cZBYlF83XAnvzj0082bixaRBHr2bDptJtCMtEMEni3wbcMpFErDS1E",
    "https://lh3.googleusercontent.com/aida-public/AB6AXuBhU7Qa5X8bQZAmozj6UOUyhfUtLh0QeRPPzX07Aohu3yhFZMHNT9_eikiL5-idRDYF3vNhzKyHkcbW9ZfEAdBMG81GzeRwgqZfIXkVc3avQvMPq-qTN0z9HHhlWSGXHpBkxe80Vd5YaYimu8V129mTLWFzOBBOowEWGYAkRwNX4LOrMdXlSt1JnLUmsqNPMGAnbu7zGecP1Pubw41J6TqErGnvGT7ZgqXQNvaMcbQhTTys-CzjT_TdiocTr8HkezE5aFvg21HpSt0",
    "https://lh3.googleusercontent.com/aida-public/AB6AXuBpSG3vKSIDcEwfSFpSBP2QaHklhtBl6LYnkOLWS-nUIRHqLmii_s5Vyh5AASo99AAQJYLp35ohbrFVX3_ShuQNGHtMQ9QpHAsUyiF5UYCl1QAHalU3n37uJjtFhhv4rsT9ASGxA7G8z7alBAs826C2dh7SupPrTXcFNYwyuTnLyDyzUkUz3KVuLiVNtX-5Oun817rOyk-nagI0GZClaMqCTk5zWUR0O0mHplA8Es3N5wkHv5MX8ip2JmBk3Ts2FTi7aitq6y-ChXA",
    "https://lh3.googleusercontent.com/aida-public/AB6AXuCvdGcxmyXzknxw_MCjBscVt9IIHhIqJfXUUqTLr98a5Aldzk_yyCH86E1_J1G3WrWCj1mU-PDid5CHR5_4p97xT_T6eL-MRGPjt-Y2IMmc2FSE9sDmjOxpFkAdzUjpnhGitTuhaVD47tvZo88qxoQnFUGMLK69uhfIsJ_QFVWAsfRwTC8Jy8pnDiDR3EzwxKj587Lc-cAsatIeeZ3SH1QKUe7fqwxQzDrJZmQfTTKf_lj2zPrDQVLROlxj7_A4F9cpxy4UBl2g9EY",
    "https://lh3.googleusercontent.com/aida-public/AB6AXuCwKFTiczEuQ-ehaNvzkO0qYa5Fpt042FUrH6F_iB98KnOqubm8OucgrrJmEhPEQPPkUq2qX_DewL78K7U8g906fSO7biU00UWZyl_qpjje3fnZRKeVC4ryrGdiy8P1pZ1HgqgPW9gSf_ysE_vFNDqrAjCE87dDxzw9ucsOeCTu86MeHbIEaeVHZmZKSwcDO7_6ZldApz_18UOYlWUTKEDY8WEYPdDKdMSIZG1wBFPfAusA6y-LY88IKYxfdXrZ7Z-w6sL7w2hKLTA",
    "https://lh3.googleusercontent.com/aida-public/AB6AXuDpf493Ac08xCsf196JDnEOyut5O83fbYV_K6xPCZjpOHVQVTZ0KywKAiI1EYIl1sCN-Irg2jYGAXMxURDCrCzCmeyr7P16kqyepHUGzUWPoICh7cDPfJvTqhY7RgfU4xcC3pKDTa4EtI-59-Sx8WRUY3I6-qSnFOVquh66wsG9iwHe26sldRt7jvBcqQErVpQav0iVcBHAWkZTyawqvjsfpxFyN6lJta_w4z9kYd8B58p22VXb5KkyVueOZvnFcUMqqNjtbbtSG08"
];

const stories = [
    {
        id: 1,
        name: "James M.",
        role: "Monthly Donor",
        image: "https://lh3.googleusercontent.com/aida-public/AB6AXuDlXFh0IymZmXpXIty_9EXE17p5nYSYjxy9wLt9fI-sziNc1ff7N8NhlqD-n12WUdCYhfpoBxf-DWaRcLAywRpglhCjzjgljXVhiIPMSHU0y8o0DCQksQWSWAiDW5ZIqehW7_7akGmeVz5R-mExHMf1tyEeyv1HnSx1Q_YaAFlyppQjd5ss7YaB-Wof67SrKNmdkRGs1eUdnKBjY47gBxkIhgmfCV2WJPpJ8CgeIBeK-IihdKnC8Fj5E9Vs_sDhVsjYX4n2U5zzr20",
        quote: "Seeing the direct updates from the field makes me feel truly connected. Knowing exactly where my donation goes is why I've supported this NGO for 3 years.",
        featured: 1
    },
    {
        id: 2,
        name: "Sarah L.",
        role: "Community Leader",
        image: "https://lh3.googleusercontent.com/aida-public/AB6AXuAmlTSo0Is3iJzJThjbYB8qhWU_Rc_bu627pbMmsBRoix29h6N5amuns32RtOfteeetH2XTbb80-E-uZhFwIPlezilN4WU8qTwha9fLAXx8e8sesCUYIB_pOX-bqGVOdwxdVZw40JaXnYG6S4JJY7QSF3ijStC1BgOnUqy2SIE1BogERJgaUllUMS3HsydO9qXG_RXytKtARng2ftG_bpN-gG7GtT_amtZd3PghQUIN24fudwwdd4_UrFZP64aSp59ioubBytyQWmY",
        quote: "The new school supplies completely transformed our village. Girls can attend school regularly now. Thank you.",
        featured: 1
    },
    {
        id: 3,
        name: "John Doe",
        role: "Beneficiary since 2018",
        image: "https://ui-avatars.com/api/?name=John+Doe&background=10b981&color=fff",
        quote: "The support I received from Educate a Rural Girl changed my life completely. They didn't just give me food; they gave me the tools to build a future for my family.",
        featured: 0
    },
    {
        id: 4,
        name: "Elena Martinez",
        role: "Monthly Donor",
        image: "https://ui-avatars.com/api/?name=Elena+Martinez&background=7c3aed&color=fff",
        quote: "I donate to Educate a Rural Girl because I can see exactly where my money goes. Their transparency and direct impact on the ground are unmatched.",
        featured: 0
    }
];

const team = [
    {
        id: 1,
        name: "Sarah Jenkins",
        role: "Executive Director",
        image: "https://lh3.googleusercontent.com/aida-public/AB6AXuDpf493Ac08xCsf196JDnEOyut5O83fbYV_K6xPCZjpOHVQVTZ0KywKAiI1EYIl1sCN-Irg2jYGAXMxURDCrCzCmeyr7P16kqyepHUGzUWPoICh7cDPfJvTqhY7RgfU4xcC3pKDTa4EtI-59-Sx8WRUY3I6-qSnFOVquh66wsG9iwHe26sldRt7jvBcqQErVpQav0iVcBHAWkZTyawqvjsfpxFyN6lJta_w4z9kYd8B58p22VXb5KkyVueOZvnFcUMqqNjtbbtSG08"
    },
    {
        id: 2,
        name: "David Chen",
        role: "Operations Lead",
        image: "https://lh3.googleusercontent.com/aida-public/AB6AXuBnFXdirUpwpMXB27ECvPfTl0JPDeW41YYYske1azxOa8jICwcQcON4RYN-4IvbT_gAOkEvSp6APVg4atqQvuTInMHJzmhXBuHflHvxxsQupRfKKXl4L2JEe2nzWX5RR1Bl8678bouf0LSJ8s-qjtDdAHIo34g3jtRFAMGVXpVg8wtVgCFhI6_c3o4V-X3fH5hKJPSHG7wU-GHuVzH_ltkb9tkDQsPIZIZCrVC7ywMoVPQxKaaVhkjRJmp60M79X6mS-HNAXVjQM"
    },
    {
        id: 3,
        name: "Amara Okafor",
        role: "Community Outreach",
        image: "https://lh3.googleusercontent.com/aida-public/AB6AXuDscHwguZ3AEbGp3oJJAv2sOAeasQ1vJuXmJDaw-eX6vBzft6uQwjHCiueeDycdnymBH0Moa1EaH00X-tXFljc9pLIRxudXT1H-WSgbFdogUVPnFW9paKzy8_ivhb-rS9ZoV_MT0EZ-zjS4-2dSrZsb1AruQk8RgEXarT1sq7D-81U0KSdQPz4lavhJ4soMCaz21ROXbcqQXH_nVNkepshx4M04Yd1ACmMa4ew-_J0-pybZtZwSwaiJpesAUGKrHH6MFMGH7MZm_M4"
    },
    {
        id: 4,
        name: "Marcus Reid",
        role: "Volunteer Coordinator",
        image: "https://lh3.googleusercontent.com/aida-public/AB6AXuDKlYYordhofdgTOkh96RvLvQDFG8tH49kZ-RrYd2ugBD_I_C86N5kWBKiyX2tW_0A3bhHqdPgJDuW_N1d6FJ3jeAM8ld0zzVjT07_OV6rur26pkoO6NSaeStSLk6WO0JNrgK6_FIjM8wsEiGF2lVvKeoHT095TuTNJvfbpxnLbKzb52lA-jXsPzU1ZqavnPehZpiaswM46pMtbzBtZQQbtJ179g3lqafMpDk73qSfJeh4ugIdmDYxYT1sLwDFUgo-cTk5ndXn95Vg"
    }
];

const journey = [
    { id: 1, year: "2013", title: "Inception", description: "Started STEM mentorship sessions in schools." },
    { id: 2, year: "2018", title: "Formal Registration", description: "Formally registered as a Community Based Organization in Tharaka Nithi County." },
    { id: 3, year: "2019", title: "Expansion", description: "Started education and economic empowerment activities in Tharaka Nithi County." },
    { id: 4, year: "2020 - 2025", title: "Strategic Partnerships", description: "Implemented activities in Partnership with Akili Dada, KENDAT, CREAW, and the Swedish Embassy." }
];

const programs = [
    {
        title: "Values-Based Education",
        description: "We believe education is a fundamental human right. Our flagship program builds safe, well-equipped schools in underserved rural areas. We provide scholarships, textbooks, and uniforms to ensure that cost is never a barrier to learning.",
        image: "https://lh3.googleusercontent.com/aida-public/AB6AXuBhU7Qa5X8bQZAmozj6UOUyhfUtLh0QeRPPzX07Aohu3yhFZMHNT9_eikiL5-idRDYF3vNhzKyHkcbW9ZfEAdBMG81GzeRwgqZfIXkVc3avQvMPq-qTN0z9HHhlWSGXHpBkxe80Vd5YaYimu8V129mTLWFzOBBOowEWGYAkRwNX4LOrMdXlSt1JnLUmsqNPMGAnbu7zGecP1Pubw41J6TqErGnvGT7ZgqXQNvaMcbQhTTys-CzjT_TdiocTr8HkezE5aFvg21HpSt0",
        features: ["Built 12 sustainable classrooms", "Provided full scholarships to 500+ girls", "Reduced local dropout rates by 40%"]
    },
    {
        title: "Her Voice Mentorship",
        description: "Education opens the door, but confidence walks through it. Our mentorship program repairs young girls with successful local women—entrepreneurs, teachers, and leaders—to provide guidance, career advice, and emotional support.",
        image: "https://lh3.googleusercontent.com/aida-public/AB6AXuDscHwguZ3AEbGp3oJJAv2sOAeasQ1vJuXmJDaw-eX6vBzft6uQwjHCiueeDycdnymBH0Moa1EaH00X-tXFljc9pLIRxudXT1H-WSgbFdogUVPnFW9paKzy8_ivhb-rS9ZoV_MT0EZ-zjS4-2dSrZsb1AruQk8RgEXarT1sq7D-81U0KSdQPz4lavhJ4soMCaz21ROXbcqQXH_nVNkepshx4M04Yd1ACmMa4ew-_J0-pybZtZwSwaiJpesAUGKrHH6MFMGH7MZm_M4",
        features: ["Monthly Workshops", "1-on-1 Sessions", "Leadership Training"]
    },
    {
        title: "Vocational Training",
        description: "Empowering mothers and older sisters through skill development. We train women in traditional crafts, which are then sold in our shop to fund their families.",
        image: "https://lh3.googleusercontent.com/aida-public/AB6AXuD9cc7JzKPW66YsToun5n0a_T_kyo9zDV40eGPgYMNI1UvVoWHB6YguzMr7TmB9-hrGaaD-4AEG1fSLZlWjRND0VPGMCf0bAox-04huVfr3XKM0eG7kbFUrNBp_dGZbiQNW5TJttRsBHdJ-CQeHT9cfHnf978mvoIiGJEvzyl72sfB2wVG42AUwobK5nOgePyrZ8WFgkpNHySOp-l-UEt4Tbe1pjKBlBFvA0B9NncGVpCeLbMRQieib68XFQO9shEsRZPn8fdsRu_o",
        features: ["Basket Weaving", "Textile & Design", "Eco-Jewelry"]
    }
];

const defaultSettings = {
    'contact_info': {
        address: "123 Charity Lane, Education City, Nairobi, Kenya",
        email: "hello@educateruralgirl.org",
        phone: "+254 700 123 456"
    },
    'impact_stats': [
        { label: "Lives Impacted", value: "500+", icon: "favorite", trend: "+12% this month" },
        { label: "Schools Supported", value: "120", icon: "school", trend: "+5% this year" },
        { label: "Volunteers Active", value: "50+", icon: "diversity_3", trend: "+8% active now" }
    ],
    'home_hero': {
        title: "Empowering Girls,\nTransforming Futures",
        subtitle: "Join us in making a sustainable difference today. Your support provides education, resources, and hope for rural girls.",
        image: "https://lh3.googleusercontent.com/aida-public/AB6AXuBhU7Qa5X8bQZAmozj6UOUyhfUtLh0QeRPPzX07Aohu3yhFZMHNT9_eikiL5-idRDYF3vNhzKyHkcbW9ZfEAdBMG81GzeRwgqZfIXkVc3avQvMPq-qTN0z9HHhlWSGXHpBkxe80Vd5YaYimu8V129mTLWFzOBBOowEWGYAkRwNX4LOrMdXlSt1JnLUmsqNPMGAnbu7zGecP1Pubw41J6TqErGnvGT7ZgqXQNvaMcbQhTTys-CzjT_TdiocTr8HkezE5aFvg21HpSt0"
    },
    'about_hero': {
        title: "Empowering Rural Girls Since 2010",
        subtitle: "We are dedicated to building a sustainable future through education, compassion, and direct action. Join us in making a difference.",
        image: "https://lh3.googleusercontent.com/aida-public/AB6AXuCwKFTiczEuQ-ehaNvzkO0qYa5Fpt042FUrH6F_iB98KnOqubm8OucgrrJmEhPEQPPkUq2qX_DewL78K7U8g906fSO7biU00UWZyl_qpjje3fnZRKeVC4ryrGdiy8P1pZ1HgqgPW9gSf_ysE_vFNDqrAjCE87dDxzw9ucsOeCTu86MeHbIEaeVHZmZKSwcDO7_6ZldApz_18UOYlWUTKEDY8WEYPdDKdMSIZG1wBFPfAusA6y-LY88IKYxfdXrZ7Z-w6sL7w2hKLTA"
    },
    'categories': ['Handmade Crafts', 'Sustainable Apparel', 'Jewelry', 'Eco-Friendly']
};

const homeProductIds = ["p1", "p2", "p3", "p4"];

db.serialize(() => {
    // Clear and Create Tables
    db.run("DROP TABLE IF EXISTS products");
    db.run("DROP TABLE IF EXISTS gallery");
    db.run("DROP TABLE IF EXISTS stories");
    db.run("DROP TABLE IF EXISTS team");
    db.run("DROP TABLE IF EXISTS journey");
    db.run("DROP TABLE IF EXISTS programs");
    db.run("DROP TABLE IF EXISTS messages");
    db.run("DROP TABLE IF EXISTS reviews");
    db.run("DROP TABLE IF EXISTS settings");
    db.run("DROP TABLE IF EXISTS orders");
    db.run("DROP TABLE IF EXISTS wishlist");

    db.run(`CREATE TABLE products (
        id TEXT PRIMARY KEY,
        name TEXT,
        price REAL,
        category TEXT,
        rating REAL,
        reviews INTEGER,
        description TEXT,
        material TEXT,
        dimensions TEXT,
        origin TEXT,
        impact TEXT,
        details TEXT,
        story TEXT,
        images TEXT,
        stock INTEGER DEFAULT 0,
        offerPrice REAL
    )`);

    db.run(`CREATE TABLE gallery (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        url TEXT,
        caption TEXT
    )`);

    db.run(`CREATE TABLE stories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        role TEXT,
        image TEXT,
        quote TEXT,
        featured INTEGER
    )`);

    db.run(`CREATE TABLE team (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        role TEXT,
        image TEXT
    )`);

    db.run(`CREATE TABLE journey (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        year TEXT,
        title TEXT,
        description TEXT
    )`);

    db.run(`CREATE TABLE programs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        image TEXT,
        features TEXT
    )`);

    db.run(`CREATE TABLE messages (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        message TEXT,
        date TEXT,
        read BOOLEAN DEFAULT 0
    )`);

    db.run(`CREATE TABLE reviews (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_id TEXT,
        user_name TEXT,
        user_email TEXT,
        rating INTEGER,
        comment TEXT,
        approved INTEGER DEFAULT 0,
        created_at TEXT,
        FOREIGN KEY (product_id) REFERENCES products(id)
    )`);

    db.run(`CREATE TABLE orders (
        id TEXT PRIMARY KEY,
        customer_email TEXT,
        customer_name TEXT,
        items TEXT,
        total REAL,
        status TEXT DEFAULT 'pending',
        payment_method TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )`);

    db.run(`CREATE TABLE wishlist (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        session_id TEXT,
        product_id TEXT,
        added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )`);

    db.run(`CREATE TABLE settings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        key TEXT UNIQUE,
        value TEXT
    )`);

    // Insert Products
    const stmt = db.prepare("INSERT INTO products VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    products.forEach(p => {
        stmt.run(p.id, p.name, p.price, p.category, p.rating, p.reviews, p.description, p.material, p.dimensions, p.origin, p.impact, p.details, p.story, p.images, p.stock || 0, p.offerPrice || null);
    });
    stmt.finalize();

    // Insert Gallery
    const galleryStmt = db.prepare("INSERT INTO gallery (url) VALUES (?)");
    galleryImages.forEach(url => {
        galleryStmt.run(url);
    });
    galleryStmt.finalize();

    // Insert Stories
    const storyStmt = db.prepare("INSERT INTO stories (name, role, image, quote, featured) VALUES (?, ?, ?, ?, ?)");
    stories.forEach(s => {
        storyStmt.run(s.name, s.role, s.image, s.quote, s.featured);
    });
    storyStmt.finalize();

    // Insert Team
    const teamStmt = db.prepare("INSERT INTO team (name, role, image) VALUES (?, ?, ?)");
    team.forEach(t => {
        teamStmt.run(t.name, t.role, t.image);
    });
    teamStmt.finalize();

    // Insert Journey
    const journeyStmt = db.prepare("INSERT INTO journey (year, title, description) VALUES (?, ?, ?)");
    journey.forEach(j => {
        journeyStmt.run(j.year, j.title, j.description);
    });
    journeyStmt.finalize();

    // Insert Programs
    const progStmt = db.prepare("INSERT INTO programs (title, description, image, features) VALUES (?, ?, ?, ?)");
    programs.forEach(p => {
        progStmt.run(p.title, p.description, p.image, JSON.stringify(p.features));
    });
    progStmt.finalize();

    // Insert Settings
    const setStmt = db.prepare("INSERT INTO settings (key, value) VALUES (?, ?)");

    // Add defaults
    for (const [key, value] of Object.entries(defaultSettings)) {
        setStmt.run(key, JSON.stringify(value));
    }

    // Add home product ids if not already in defaults
    setStmt.run('home_products', JSON.stringify(homeProductIds));

    setStmt.finalize();

    console.log("Database seeded successfully with all schemas.");
});

db.close();
