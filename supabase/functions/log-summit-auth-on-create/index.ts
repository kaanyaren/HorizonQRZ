import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from "https://esm.sh/@supabase/supabase-js@2"

serve(async (req) => {
  const { user } = await req.json()
  
  if (!user) {
    return new Response(JSON.stringify({ error: "No user provided" }), { 
      status: 400,
      headers: { "Content-Type": "application/json" } 
    })
  }

  const supabase = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
  )

  // Check if profile already exists
  const { data: existing, error: checkError } = await supabase
    .from("profiles")
    .select("id")
    .eq("id", user.id)
    .single()

  if (checkError || existing) {
    return new Response(JSON.stringify({ error: "Profile already exists" }), { 
      status: 409,
      headers: { "Content-Type": "application/json" } 
    })
  }

  // Create initial profile
  const { error } = await supabase
    .schema("log_summit")
    .from("profiles")
    .insert({
      id: user.id,
      callsign: "", // User must set callsign on first launch
    })

  if (error) {
    console.error("Error creating profile:", error)
    return new Response(JSON.stringify({ error: error.message }), { 
      status: 500,
      headers: { "Content-Type": "application/json" } 
    })
  }

  return new Response(JSON.stringify({ success: true }), { 
    status: 200,
    headers: { "Content-Type": "application/json" } 
  })
})
