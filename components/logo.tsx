import React from "react";

interface LogoProps {
  className?: string;
  iconOnly?: boolean;
  size?: "sm" | "md" | "lg" | "xl";
}

export function Logo({ className = "", iconOnly = false, size = "md" }: LogoProps) {
  const sizeClasses = {
    sm: { icon: "w-6 h-6", text: "text-lg", sub: "text-[8px]" },
    md: { icon: "w-9 h-9", text: "text-xl", sub: "text-[10px]" },
    lg: { icon: "w-12 h-12", text: "text-2xl", sub: "text-[12px]" },
    xl: { icon: "w-16 h-16", text: "text-3xl", sub: "text-[14px]" },
  };

  const currentSize = sizeClasses[size];

  return (
    <div className={`flex items-center space-x-3 select-none ${className}`}>
      {/* Custom High-Fidelity SVG Icon representing the SecondMind S-Head Logo */}
      <div className={`relative ${currentSize.icon} flex-shrink-0`}>
        <svg
          viewBox="0 0 100 100"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
          className="w-full h-full"
        >
          <defs>
            <linearGradient id="sec-mind-gradient" x1="0%" y1="0%" x2="100%" y2="100%">
              <stop offset="0%" stopColor="#10B981" /> {/* Emerald */}
              <stop offset="50%" stopColor="#34D399" /> {/* Mint */}
              <stop offset="100%" stopColor="#059669" /> {/* Darker Emerald */}
            </linearGradient>
            <filter id="glow" x="-10%" y="-10%" width="120%" height="120%">
              <feDropShadow dx="0" dy="2" stdDeviation="3" floodColor="#10B981" floodOpacity="0.2" />
            </filter>
          </defs>

          {/* S-shaped Outer Head Profile Ribbon */}
          <path
            d="M 52,15 
               C 68,15 76,26 76,38 
               C 76,46 72,50 68,54 
               C 63,59 64,63 67,65
               C 72,68 76,71 76,76
               C 76,85 64,88 52,88
               C 38,88 28,79 28,70
               C 28,64 33,60 38,62
               C 42,64 43,69 41,72
               C 39,76 44,79 52,79
               C 58,79 66,76 66,72
               C 66,68 60,65 54,62
               C 44,57 37,51 37,40
               C 37,28 46,15 52,15 Z"
            fill="url(#sec-mind-gradient)"
            filter="url(#glow)"
          />

          {/* Neural Connections inside the Head Shape */}
          <g opacity="0.9">
            {/* Connection Lines */}
            <line x1="52" y1="28" x2="62" y2="35" stroke="#ffffff" strokeWidth="1.5" strokeOpacity="0.6" />
            <line x1="52" y1="28" x2="44" y2="38" stroke="#ffffff" strokeWidth="1.5" strokeOpacity="0.6" />
            <line x1="62" y1="35" x2="58" y2="48" stroke="#ffffff" strokeWidth="1.5" strokeOpacity="0.6" />
            <line x1="44" y1="38" x2="58" y2="48" stroke="#ffffff" strokeWidth="1.5" strokeOpacity="0.6" />
            <line x1="44" y1="38" x2="48" y2="52" stroke="#ffffff" strokeWidth="1.5" strokeOpacity="0.6" />
            <line x1="58" y1="48" x2="48" y2="52" stroke="#ffffff" strokeWidth="1.5" strokeOpacity="0.6" />

            {/* Neural Nodes (Glowing White Circles) */}
            <circle cx="52" cy="28" r="3" fill="#ffffff" />
            <circle cx="62" cy="35" r="3" fill="#ffffff" />
            <circle cx="44" cy="38" r="3.5" fill="#ffffff" />
            <circle cx="58" cy="48" r="3" fill="#ffffff" />
            <circle cx="48" cy="52" r="2.5" fill="#ffffff" />
          </g>
        </svg>
      </div>

      {!iconOnly && (
        <div className="flex flex-col">
          <span className={`font-bold tracking-tight text-white leading-tight ${currentSize.text}`}>
            secondmind<span className="text-emerald-400">.ai</span>
          </span>
          <span className={`font-semibold tracking-widest text-slate-400 uppercase font-mono ${currentSize.sub}`}>
            PERSONAL AI AGENT
          </span>
        </div>
      )}
    </div>
  );
}
