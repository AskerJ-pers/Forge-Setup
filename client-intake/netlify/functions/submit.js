// Forge GTM — client intake submission handler
// Netlify serverless function
// Builds intake.md from form data and commits to the Client-Submissions private repo via GitHub API.

const GITHUB_API = 'https://api.github.com';

exports.handler = async function (event) {
  if (event.httpMethod !== 'POST') {
    return { statusCode: 405, body: 'Method not allowed' };
  }

  const token = process.env.GITHUB_TOKEN;
  const repo  = process.env.GITHUB_SUBMISSIONS_REPO; // e.g. AskerJ-pers/Client-Submissions

  if (!token || !repo) {
    console.error('Missing environment variables: GITHUB_TOKEN or GITHUB_SUBMISSIONS_REPO');
    return { statusCode: 500, body: 'Server configuration error' };
  }

  let data;
  try {
    data = JSON.parse(event.body);
  } catch {
    return { statusCode: 400, body: 'Invalid JSON' };
  }

  // Build markdown content
  const now = new Date().toISOString();
  const dateStamp = now.slice(0, 10); // YYYY-MM-DD

  const materialsStr = (data.materials || []).length
    ? data.materials.join(', ')
    : 'Not specified';

  const md = `# Client intake — ${esc(data.company_name)}
Submitted: ${now}

---

## Company

**Name:** ${esc(data.company_name)}
**Industry:** ${esc(data.industry)}
**Size:** ${esc(data.company_size) || 'Not provided'}
**Website:** ${esc(data.website)}
**LinkedIn:** ${esc(data.linkedin) || 'Not provided'}
**Other social profiles:** ${esc(data.other_social) || 'Not provided'}

---

## Products and services

**What they do:**
${esc(data.what_you_do)}

**Products or service lines:**
${esc(data.products_list) || 'Not provided'}

**Differentiators:**
${esc(data.differentiators) || 'Not provided'}

**Key terminology:**
${esc(data.terminology) || 'Not provided'}

---

## Buyers

**Ideal customer:**
${esc(data.ideal_customer)}

**Buyer job titles:** ${esc(data.buyer_titles) || 'Not provided'}
**Industries sold into:** ${esc(data.buyer_industries) || 'Not provided'}

**Problem solved:**
${esc(data.problem_solved)}

**Customer voice / quotes:**
${esc(data.customer_voice) || 'Not provided'}

---

## Brand

**Has brand guidelines:** ${esc(data.has_guidelines)}
**Has vector logo (SVG/PDF):** ${esc(data.has_logo)}
**Has existing marketing materials:** ${esc(data.has_materials)}
**Brand files sharing link:** ${esc(data.brand_files_link) || 'Not provided'}

---

## Goals

**Materials needed:** ${materialsStr}
**Timeline:** ${esc(data.timeline) || 'Not specified'}

**Success criteria:**
${esc(data.success_criteria) || 'Not provided'}

**Additional notes:**
${esc(data.additional_notes) || 'Not provided'}

---

## Contact

**Name:** ${esc(data.contact_name)}
**Title:** ${esc(data.contact_title) || 'Not provided'}
**Email:** ${esc(data.contact_email)}
`;

  // Build file path in repo
  const slug = slugify(data.company_name || 'unknown');
  const filePath = `submissions/${slug}/${dateStamp}-intake.md`;
  const commitMessage = `Add intake: ${data.company_name || 'Unknown'} (${dateStamp})`;

  const url = `${GITHUB_API}/repos/${repo}/contents/${filePath}`;

  const payload = {
    message: commitMessage,
    content: Buffer.from(md, 'utf8').toString('base64'),
  };

  try {
    const response = await fetch(url, {
      method: 'PUT',
      headers: {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json',
        'Accept': 'application/vnd.github+json',
        'X-GitHub-Api-Version': '2022-11-28',
      },
      body: JSON.stringify(payload),
    });

    if (response.status === 201 || response.status === 200) {
      return { statusCode: 200, body: JSON.stringify({ ok: true }) };
    }

    const errorBody = await response.text();
    console.error('GitHub API error:', response.status, errorBody);
    return { statusCode: 500, body: 'Failed to write to GitHub' };

  } catch (err) {
    console.error('Fetch error:', err);
    return { statusCode: 500, body: 'Network error' };
  }
};

// Escape markdown special chars in field values
function esc(val) {
  if (!val) return '';
  return String(val).trim();
}

// Create a URL-safe slug from a company name
function slugify(str) {
  return str
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
    .slice(0, 60) || 'unknown';
}
